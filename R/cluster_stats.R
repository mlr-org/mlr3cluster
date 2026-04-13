cluster_wss = function(x, clustering) {
  wss = 0
  for (cl in unique(clustering)) {
    members = x[clustering == cl, , drop = FALSE]
    centroid = colMeans(members)
    wss = wss + sum(sweep(members, 2L, centroid)^2)
  }
  wss
}

cluster_ch = function(x, clustering) {
  n = nrow(x)
  k = length(unique(clustering))
  wss = cluster_wss(x, clustering)
  tss = sum(sweep(x, 2L, colMeans(x))^2)
  bss = tss - wss
  (n - k) * bss / ((k - 1L) * wss)
}

cluster_dunn = function(d, clustering) {
  clusters = sort(unique(clustering))
  k = length(clusters)

  diameter = numeric(k)
  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    if (length(idx) < 2L) {
      diameter[i] = 0
    } else {
      diameter[i] = max(stats::as.dist(d[idx, idx]))
    }
  }

  separation = Inf
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      separation = min(separation, min(d[idx_i, idx_j]))
    }
  }

  separation / max(diameter)
}

cluster_dunn2 = function(d, clustering) {
  clusters = sort(unique(clustering))
  k = length(clusters)

  avg_within = numeric(k)
  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    if (length(idx) < 2L) {
      avg_within[i] = 0
    } else {
      avg_within[i] = mean(stats::as.dist(d[idx, idx]))
    }
  }

  min_avg_between = Inf
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      min_avg_between = min(min_avg_between, mean(d[idx_i, idx_j]))
    }
  }

  min_avg_between / max(avg_within)
}

cluster_wb_ratio = function(d, clustering) {
  cluster_avg_within(d, clustering) / cluster_avg_between(d, clustering)
}

cluster_pearsongamma = function(d, clustering) {
  clusters = sort(unique(clustering))
  k = length(clusters)
  n = length(clustering)
  sizes = as.integer(table(clustering))

  n_within = sum(sizes * (sizes - 1L) / 2L)
  n_between = n * (n - 1L) / 2L - n_within

  within_dist = numeric(n_within)
  between_dist = numeric(n_between)

  iw = 1L
  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    if (length(idx) >= 2L) {
      vals = stats::as.dist(d[idx, idx])
      within_dist[iw:(iw + length(vals) - 1L)] = vals
      iw = iw + length(vals)
    }
  }

  ib = 1L
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      vals = d[idx_i, idx_j]
      between_dist[ib:(ib + length(vals) - 1L)] = vals
      ib = ib + length(vals)
    }
  }

  stats::cor(
    c(within_dist, between_dist),
    c(rep(0, n_within), rep(1, n_between))
  )
}

cluster_entropy = function(clustering) {
  n = length(clustering)
  sizes = as.integer(table(clustering))
  p = sizes[sizes > 0L] / n
  -sum(p * log(p))
}

cluster_avg_between = function(d, clustering) {
  clusters = sort(unique(clustering))
  k = length(clusters)

  total = 0
  count = 0L
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      vals = d[idx_i, idx_j]
      total = total + sum(vals)
      count = count + length(vals)
    }
  }
  total / count
}

cluster_avg_within = function(d, clustering) {
  clusters = sort(unique(clustering))
  k = length(clusters)

  cluster_avg = numeric(k)
  cluster_size = numeric(k)

  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    cluster_size[i] = length(idx)
    if (length(idx) >= 2L) {
      cluster_avg[i] = mean(stats::as.dist(d[idx, idx]))
    } else {
      cluster_avg[i] = NA
    }
  }

  stats::weighted.mean(cluster_avg, cluster_size, na.rm = TRUE)
}

cluster_davies_bouldin = function(x, clustering) {
  clusters = sort(unique(clustering))
  k = length(clusters)

  centroids = matrix(0, nrow = k, ncol = ncol(x))
  scatter = numeric(k)
  for (i in seq_along(clusters)) {
    members = x[clustering == clusters[i], , drop = FALSE]
    centroids[i, ] = colMeans(members)
    scatter[i] = mean(sqrt(rowSums(sweep(members, 2L, centroids[i, ])^2)))
  }

  db = numeric(k)
  for (i in seq_len(k)) {
    max_ratio = -Inf
    for (j in seq_len(k)) {
      if (i != j) {
        d_ij = sqrt(sum((centroids[i, ] - centroids[j, ])^2))
        ratio = (scatter[i] + scatter[j]) / d_ij
        max_ratio = max(max_ratio, ratio)
      }
    }
    db[i] = max_ratio
  }
  mean(db)
}

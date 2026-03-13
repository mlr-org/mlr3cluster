cluster_wss = function(x, clustering) {
  x = as.matrix(x)
  wss = 0
  for (cl in unique(clustering)) {
    members = x[clustering == cl, , drop = FALSE]
    centroid = colMeans(members)
    wss = wss + sum(sweep(members, 2L, centroid)^2)
  }
  wss
}

cluster_ch = function(x, clustering) {
  x = as.matrix(x)
  n = nrow(x)
  k = length(unique(clustering))
  W = matrix(0, ncol(x), ncol(x))
  for (cl in unique(clustering)) {
    members = x[clustering == cl, , drop = FALSE]
    ni = nrow(members)
    if (ni < 2L) {
      next
    }
    W = W + (ni - 1L) * cov(members)
  }
  S = (n - 1L) * cov(x)
  B = S - W
  (n - k) * sum(diag(B)) / ((k - 1L) * sum(diag(W)))
}

cluster_dunn = function(d, clustering) {
  dmat = as.matrix(d)
  clusters = sort(unique(clustering))
  k = length(clusters)

  diameter = numeric(k)
  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    if (length(idx) < 2L) {
      diameter[i] = 0
    } else {
      diameter[i] = max(dmat[idx, idx])
    }
  }

  separation = Inf
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      separation = min(separation, min(dmat[idx_i, idx_j]))
    }
  }

  separation / max(diameter)
}

cluster_dunn2 = function(d, clustering) {
  dmat = as.matrix(d)
  clusters = sort(unique(clustering))
  k = length(clusters)

  avg_within = numeric(k)
  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    if (length(idx) < 2L) {
      avg_within[i] = 0
    } else {
      avg_within[i] = mean(as.dist(dmat[idx, idx]))
    }
  }

  min_avg_between = Inf
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      min_avg_between = min(min_avg_between, mean(dmat[idx_i, idx_j]))
    }
  }

  min_avg_between / max(avg_within)
}

cluster_wb_ratio = function(d, clustering) {
  dmat = as.matrix(d)
  clusters = sort(unique(clustering))
  k = length(clusters)

  between_dist = numeric()
  cluster_avg = numeric(k)
  cluster_size = numeric(k)

  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    cluster_size[i] = length(idx)
    if (length(idx) >= 2L) {
      cluster_avg[i] = mean(as.dist(dmat[idx, idx]))
    } else {
      cluster_avg[i] = NA
    }
  }

  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      between_dist = c(between_dist, dmat[idx_i, idx_j])
    }
  }

  avg_within = weighted.mean(cluster_avg, cluster_size, na.rm = TRUE)
  avg_between = mean(between_dist)
  avg_within / avg_between
}

cluster_pearsongamma = function(d, clustering) {
  dmat = as.matrix(d)
  clusters = sort(unique(clustering))
  k = length(clusters)

  within_dist = numeric()
  between_dist = numeric()

  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    if (length(idx) >= 2L) {
      within_dist = c(within_dist, as.dist(dmat[idx, idx]))
    }
  }

  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      between_dist = c(between_dist, dmat[idx_i, idx_j])
    }
  }

  cor(
    c(within_dist, between_dist),
    c(rep(0, length(within_dist)), rep(1, length(between_dist)))
  )
}

cluster_entropy = function(clustering) {
  n = length(clustering)
  sizes = tabulate(clustering)
  p = sizes[sizes > 0L] / n
  -sum(p * log(p))
}

cluster_avg_between = function(d, clustering) {
  dmat = as.matrix(d)
  clusters = sort(unique(clustering))
  k = length(clusters)

  between_dist = numeric()
  for (i in seq_len(k - 1L)) {
    idx_i = which(clustering == clusters[i])
    for (j in (i + 1L):k) {
      idx_j = which(clustering == clusters[j])
      between_dist = c(between_dist, dmat[idx_i, idx_j])
    }
  }
  mean(between_dist)
}

cluster_avg_within = function(d, clustering) {
  dmat = as.matrix(d)
  clusters = sort(unique(clustering))
  k = length(clusters)

  cluster_avg = numeric(k)
  cluster_size = numeric(k)

  for (i in seq_along(clusters)) {
    idx = which(clustering == clusters[i])
    cluster_size[i] = length(idx)
    if (length(idx) >= 2L) {
      cluster_avg[i] = mean(as.dist(dmat[idx, idx]))
    } else {
      cluster_avg[i] = NA
    }
  }

  weighted.mean(cluster_avg, cluster_size, na.rm = TRUE)
}

cluster_davies_bouldin = function(x, clustering) {
  x = as.matrix(x)
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

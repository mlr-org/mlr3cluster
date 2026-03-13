test_that("cluster_wss matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$within.cluster.ss
  actual = cluster_wss(x, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_ch matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$ch
  actual = cluster_ch(x, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_dunn matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$dunn
  actual = cluster_dunn(d, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_dunn2 matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$dunn2
  actual = cluster_dunn2(d, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_wb_ratio matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$wb.ratio
  actual = cluster_wb_ratio(d, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_pearsongamma matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$pearsongamma
  actual = cluster_pearsongamma(d, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_entropy matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$entropy
  actual = cluster_entropy(clustering)
  expect_equal(actual, expected)
})

test_that("cluster_avg_between matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$average.between
  actual = cluster_avg_between(d, clustering)
  expect_equal(actual, expected)
})

test_that("cluster_avg_within matches fpc", {
  skip_if_not_installed("fpc")
  x = as.matrix(datasets::USArrests)
  d = dist(x)
  clustering = kmeans(scale(x), centers = 3L, nstart = 10L)$cluster

  expected = fpc::cluster.stats(d, clustering, silhouette = FALSE)$average.within
  actual = cluster_avg_within(d, clustering)
  expect_equal(actual, expected)
})

test_that("cluster measures match fpc with different k", {
  skip_if_not_installed("fpc")
  x = as.matrix(iris[, 1:4])
  d = dist(x)

  for (k in c(2L, 3L, 5L)) {
    clustering = kmeans(x, centers = k, nstart = 10L)$cluster
    fpc_stats = fpc::cluster.stats(d, clustering, silhouette = FALSE)

    expect_equal(cluster_wss(x, clustering), fpc_stats$within.cluster.ss, info = sprintf("wss k=%d", k))
    expect_equal(cluster_ch(x, clustering), fpc_stats$ch, info = sprintf("ch k=%d", k))
    expect_equal(cluster_dunn(d, clustering), fpc_stats$dunn, info = sprintf("dunn k=%d", k))
    expect_equal(cluster_dunn2(d, clustering), fpc_stats$dunn2, info = sprintf("dunn2 k=%d", k))
    expect_equal(cluster_wb_ratio(d, clustering), fpc_stats$wb.ratio, info = sprintf("wb_ratio k=%d", k))
    expect_equal(cluster_pearsongamma(d, clustering), fpc_stats$pearsongamma, info = sprintf("pearsongamma k=%d", k))
    expect_equal(cluster_entropy(clustering), fpc_stats$entropy, info = sprintf("entropy k=%d", k))
    expect_equal(cluster_avg_between(d, clustering), fpc_stats$average.between, info = sprintf("avg_between k=%d", k))
    expect_equal(cluster_avg_within(d, clustering), fpc_stats$average.within, info = sprintf("avg_within k=%d", k))
  }
})

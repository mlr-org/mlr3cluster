devtools::load_all()

task = tsk("usarrests")
learner = lrn("clust.kmeans", centers = 3)

learner$train(task)
learner$model
prediction = learner$predict(task)
print(prediction)

rr = resample(task, learner, rsmp("cv", folds = 3))
measures = msrs(c("clust.dunn", "clust.db", "clust.silhouette"))
rr$aggregate(measures)

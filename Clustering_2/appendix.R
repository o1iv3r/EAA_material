```{r}
library(dbscan)
dbscan_res <- dbscan(dat_num_no_missings_scaled, minPts = 6,eps=.7)
dbscan_res
```

### Gaussian Mixture Model

Gaussian Mixture Models fall into the category of probabilistic clustering methods. Models are estimated by EM algorithm.

```{r}
library(mclust)
set.seed(seed_var)
bic_res <- mclustBIC(dat_num_no_missings_scaled,G=5:8)
```



```{r}
plot(bic_res,what="BIC",legendArgs = list(x="top"))
```

```{r}
# too slow
#  <- mclustBootstrapLRT(dat_num_no_missings_scaled, modelName = "EII",nboot=10,maxG = 8)
```



```{r}
set.seed(seed_var)
mclust_res <- Mclust(dat_num_no_missings_scaled,x=bic_res,G=7)
summary(mclust_res)
```

a plot showing the clustering. For data in more than two dimensions a pairs plot is produced, followed by a coordinate projection plot using specified dimens. Ellipses corresponding to covariances of mixture components

```{r fig.width=15, fig.height=15}
plot(mclust_res,what="classification",addEllipses =TRUE)
```

### hclust - only nice for small number of points




### Some mixed data type stuff

Some algorithms cannot deal with categorical data. However, one may compute the distance matrix a-priori using Gower's distance and use this as an input to the clustering algorithm. With that, each variable (column) is first standardized by dividing each entry by the range of the corresponding variable, after subtracting the minimum value; consequently the rescaled variable has range [0,1], exactly.

```{r}
library(cluster)
dist_dat_no_missings<- daisy(dat_no_missings,
                                     metric = "gower",
                                     stand = TRUE)
```

```{r}
dat_no_missings_onehot <- model.matrix(paste("~0 +",
                                             paste(colnames(dat_no_missings),collapse=' + ')),
                                       data = dat_no_missings)
```
```{r}
library(mltools)
dat_no_missings_onehot_scaled <- scale(one_hot(dat_no_missings))
```



```{r}
dat_no_missings_numeric = dat_no_missings[,mget(c(num_vars))]
```


FOR NOW USE THESE DATA MATRICES

```{r}
dat_num_no_missings_scaled <- scale(dat_no_missings_numeric)
```



```{r}
pam_res <- pam(dist_dat_no_missings, k= nr_clusters)
```

The medoids are quite hard to interpret since they are referring to the distance matrix, but we will only look at the cluster assignments and compare this with result from above when only numeric variables are used

```{r}
library(ClusterR)
external_validation(true_labels = pam_res$clustering, clusters = predict(cclust_res))
```


```{r}
pam_numeric_res <- pam(dat_num_no_missings_scaled, k=nr_clusters)
external_validation(true_labels = pam_numeric_res$clustering, 
                    clusters = predict(cclust_res))
```


```{r}
cclust_onehot_res <- cclust(dat_no_missings_onehot_scaled , k=nr_clusters)
```



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




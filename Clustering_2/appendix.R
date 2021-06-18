```{r}
library(dbscan)
dbscan_res <- dbscan(dat_num_no_missings_scaled, minPts = 6,eps=.7)
dbscan_res
```
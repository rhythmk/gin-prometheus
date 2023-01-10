# 一、 参考文档

**Prometheus**

- 官方文档：https://prometheus.io/docs/introduction/first_steps/

- 中文文档： https://prometheus.fuckcloudnative.io/di-yi-zhang-jie-shao/overview

**grafana** 

- 官方文档：
  
   https://grafana.com/docs/

- Grafana 中文入门教程
  
  https://cloud.tencent.com/developer/article/1807679



# 二、接入gin

安装包

```
go get	github.com/prometheus/client_golang/prometheus/promhttp

```

定义 handler
```golang
func PromHandler(handler http.Handler) gin.HandlerFunc {
	return func(c *gin.Context) {
		handler.ServeHTTP(c.Writer, c.Request)
	}
}
```

接入路由

```golang
r.GET("metrics", PromHandler(promhttp.Handler()))
```
启动服务，浏览地址：

http://localhost:9876/metrics

# 三、运行
启动 docker-compose


web:
http://119.91.146.245:9876/metrics

prometheus
http://119.91.146.245:9099/graph

grafana
http://119.91.146.245:3099/grafana
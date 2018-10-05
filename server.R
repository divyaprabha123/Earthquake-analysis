server=function(input, output, session) {
  
  library("tseries")
  library("forecast")
  
  xy<-read.csv('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv')
  y<-(xy$mag)
  output$ii<-renderPrint({
    r<-(xy$time)
    print(paste("Last updated at ",r[1]))
  })
  output$plot2<-renderPlot({
    
    y<-(y[!is.na(y)])
    timeseries<-ts(y)
    xdif<-diff(timeseries)
    xdif<-(xdif[!is.na(xdif)])
    
    plot(acf(xdif),main='Auto Correlation of the given vector',col='red',lty=2,pch=2)
    
  })
  output$plot21<-renderPlot({
    library("RODBC")
    library("RODBCext")
    con<-odbcConnect("orc2",uid="system",pwd="system")
    xx1<-sqlQuery(con,"select *from earthquake")
    y<-xx1[!is.na(xx1)]
    timeseries<-ts(y)
    xdif<-diff(timeseries)
    xdif<-(xdif[!is.na(xdif)])
    
    plot(acf(xdif),main='Auto Correlation of the given vector',col='red',lty=2,pch=2,binwidth=0.2)
    
  })
  output$plot3<-renderPlot({
    
    y<-y[!is.na(y)]
    timeseries<-ts(y)
    timeseries 
    xdif<-diff(timeseries)
    xdif<-(xdif[!is.na(xdif)])
    plot(pacf(xdif),main='Partial Auto Correlation of the given vector',col='red',lty=2,pch=2)
  })
  output$plot31<-renderPlot({
    library("RODBC")
    library("RODBCext")
    
    con<-odbcConnect("orc2",uid="system",pwd="system")
    timeseries<-ts(y)
    timeseries 
    xdif<-diff(timeseries)
    xdif<-(xdif[!is.na(xdif)])
    plot(pacf(xdif),main='Partial Auto Correlation of the given vector',col='red',lty=2,pch=2)
  })
  
  output$b2<-renderPrint({
    
    y<-(y[!is.na(y)])
    timeseries<-ts(y)
    xdif<-diff(timeseries)
    xdif<-(xdif[!is.na(xdif)])
    auto<-auto.arima(y)
    b<-as.numeric(input$b2)
    forecast(auto,b)
    ##plot(forecast(auto,2))
    
  })
  output$b61<-renderPrint({
    library("RODBC")
    library("RODBCext")
    
    con<-odbcConnect("orc2",uid="system",pwd="system")
    x1 <- as.numeric(unlist(strsplit(input$a,",")))
    for (i in 1:length(x1)){
      sqls<-sprintf("Insert into earthquake values(%f)",x1[i])
      sqlExecute(con,sqls)
    }
    y1<-sqlQuery(con,"select *from earthquake")
    
    y1<-(y1[!is.na(y1)])
    timeseries<-ts(y1)
    xdif<-diff(timeseries)
    xdif<-(xdif[!is.na(xdif)])
    auto<-auto.arima(y1)
    b<-as.numeric(input$b2)
    forecast(auto,2)
    ##plot(forecast(auto,2))
    
  })
  output$oid2<-renderPrint({
    xx <- as.numeric(unlist(strsplit(input$a,",")))
    cat("As atomic vector:\n")
    print(xx)
  }
  )
  output$plot <- renderPlot({
    xx<-ts(y[!is.na(y)],freq=31)
    n=length(xx)
    
    #tsplot(xx,ylab="magnitude",xlab="minutes")
    Per=Mod(fft(xx-mean(xx)))^2/n
    Freq=(1:n -1)/n
    plot(Freq[1:50],Per[1:50],type='o',ylab="periodogram",xlab="frequency",main="Periodogram",col='red',lty=2,pch=2)
    
  })
  output$plotp <- renderPlot({
    library("RODBC")
    library("RODBCext")
    
    con<-odbcConnect("orc2",uid="system",pwd="system")
    xx1<-sqlQuery(con,"select *from earthquake")
    xx<-xx1[!is.na(xx1)]
    n<-length(xx)
    #tsplot(xx,ylab="magnitude",xlab="minutes")
    Per=Mod(fft(xx-mean(xx)))^2/n
    Freq=(1:n -1)/n
    plot(Freq[1:50],Per[1:50],type='o',ylab="periodogram",xlab="frequency",main="Periodogram",col='red',lty=2,pch=2)
    
  })
  output$plot4 <-renderPlot({
    xx <- as.numeric(unlist(strsplit(input$a,",")))
    plot(xx,main="plot",col='red')
  })
  output$tables <- DT::renderDataTable({
    
    d<-data.frame(xy$time,xy$latitude,xy$longitude,xy$mag,xy$depth,xy$place)
    DT::datatable(d)
  })
  output$table <- DT::renderDataTable({
    x<-read.csv('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.csv')
    d<-data.frame(x$time,x$latitude,x$longitude,x$mag,x$depth,x$place)
    DT::datatable(d,options = list(paging = FALSE))
  })
  
  output$summary2 <- renderPrint({
    
    
    
    summary(y)
    
    
  })
  output$T5 <- renderPrint({
    xy<-read.csv('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv')
    xx<-(xy$mag)
    xx<-xx[!is.na(xx)]
    y<-as.vector(time(xx))
    b2<-as.numeric(input$T)
    b<-(1/b2)
    r1 <- lm( xx ~ (sin(2*pi*y/b) + cos(2*pi*y/b)) )
    a<-length(xx)+5
    p<-(summary(r1)$coefficients[1,1])+((summary(r1)$coefficients[2,1])*sin(2 * pi * a /b) )+( (summary(r1)$coefficients[3,1])*cos(2 * pi *a /b))
    print(paste('Predicted value of EarthQuake magnitude for the next 15 minutes ',p))
    
    
  })
  output$E2 <- renderPrint({
    library("RODBC")
    library("RODBCext")
    
    con<-odbcConnect("orc2",uid="system",pwd="system")
    x1 <- as.numeric(unlist(strsplit(input$a,",")))
    for (i in 1:length(x1)){
      sqls<-sprintf("Insert into earthquake values(%f)",x1[i])
      sqlExecute(con,sqls)
    }
    xx1<-sqlQuery(con,"select *from earthquake")
    xx<-xx1[!is.na(xx1)]
    y <- as.vector(time(xx))
    b2<-as.numeric(input$T2)
    b<-(1/b2)
    r1 <- lm( xx ~ sin(2*pi*y/b) + cos(2*pi*y/b) )
    a<-length(xx)+5
    p<-(summary(r1)$coefficients[1,1])+((summary(r1)$coefficients[2,1])*sin(2 * pi * a /b) )+( (summary(r1)$coefficients[3,1])*cos(2 * pi *a /b))
    print(paste('Predicted value of EarthQuake ',p))
    if(p<3) 
    {
      print("Since the predicted value is less than 3 there will be no significant earthquake for the next fifteen minutes")
    }
    
  })
  
}

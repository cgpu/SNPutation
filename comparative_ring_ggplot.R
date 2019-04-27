library(ggplot2)
library(extrafont)
library(cowplot)

# define blank theme - to have white background
blank_theme <- theme_minimal()+ 
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold"),
    theme(text=element_text(size=16,  family="serif"))
    
  )



dat = data.frame(count    =c(149749, 46959738), 
                 category =c("Genotyped", "Imputed"))

dat$fraction = round((dat$count / sum(dat$count)), 3)

dat$ymax = cumsum(dat$fraction)
dat$ymin = c(0, head(dat$ymax, n=-1))
dat$category <- factor(dat$category, 
                       levels = c("Genotyped", "Imputed"))


p1 = ggplot(dat, aes(fill=category,
                     ymax=ymax, 
                     ymin=ymin, 
                     xmax=4, 
                     xmin=3)) +
  geom_rect(color= NA) +
  coord_polar(theta="y") +
  xlim(c(1, 4)) 



SNP<-p1 +  blank_theme +
  theme(axis.text.x=element_blank()) +  
  theme(legend.position=c(.5, .5)) + 
  ggtitle("") +
  theme(panel.grid=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.ticks=element_blank()) + 
  theme(legend.title = element_text(size = 16,  face = "bold")) +
  theme(legend.text  = element_text(size  = 14,  face = "bold")) +
  scale_fill_brewer("SNPs") +

SNP <- SNP +  geom_label(aes(label=paste(fraction*100,"%"),
                             x=3.5,
                             y=(ymin+ymax)/2),
                         inherit.aes = TRUE, show.legend = FALSE)

SNP <- SNP + 
  
  labs(title = "",

       subtitle   = "Michigan Imputation Server",
       caption = paste0( dat$count[dat$category=="Imputed"], "  Imputed"  , "\n",
                         dat$count[dat$category=="Genotyped"] , "  Genotyped"      )  )


Michigan <- SNP


library(ggplot2)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )



dat = data.frame(count    =c(149749, 46959738), 
                 category =c("Genotyped", "Imputed"))

dat$fraction = round((dat$count / sum(dat$count)), 3)

dat$ymax = cumsum(dat$fraction)
dat$ymin = c(0, head(dat$ymax, n=-1))
dat$category <- factor(dat$category, 
                       levels = c("Genotyped", "Imputed"))


p1 = ggplot(dat, aes(fill=category,
                     ymax=ymax, 
                     ymin=ymin, 
                     xmax=4, 
                     xmin=3)) +
  geom_rect(color= NA) +
  coord_polar(theta="y") +
  xlim(c(1, 4)) 



SNP<-p1 + scale_fill_brewer("SNPs") + blank_theme +
  theme(axis.text.x=element_blank()) +  
  theme(legend.position=c(.5, .5)) + 
  ggtitle("") +
  theme(panel.grid=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.ticks=element_blank()) + 
  theme(legend.title = element_text(size = 16,  face = "bold")) +
  theme(legend.text  = element_text(size  = 14,  face = "bold")) 

SNP <- SNP +  geom_label(aes(label=paste(fraction*100,"%"),
                             x=3.5,
                             y=(ymin+ymax)/2),
                         inherit.aes = TRUE, show.legend = FALSE)

SNP <- SNP + 
  
  labs(title = "",
       
       subtitle   = "Michigan Imputation Server",
       caption = paste0( dat$count[dat$category=="Imputed"], "  Imputed"  , "\n",
                         dat$count[dat$category=="Genotyped"] , "  Genotyped"      )  )


Michigan <- SNP 




library(ggplot2)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )



dat = data.frame(count    =c(149749, 46959738), 
                 category =c("Genotyped", "Imputed"))

dat$fraction = round((dat$count / sum(dat$count)), 3)

dat$ymax = cumsum(dat$fraction)
dat$ymin = c(0, head(dat$ymax, n=-1))
dat$category <- factor(dat$category, 
                       levels = c("Genotyped", "Imputed"))


p1 = ggplot(dat, aes(fill=category,
                     ymax=ymax, 
                     ymin=ymin, 
                     xmax=4, 
                     xmin=3)) +
  geom_rect(color= NA) +
  coord_polar(theta="y") +
  xlim(c(1, 4)) 



SNP<-p1 + scale_fill_brewer("SNPs") + blank_theme +
  theme(axis.text.x=element_blank()) +  
  theme(legend.position=c(.5, .5)) + 
  ggtitle("") +
  theme(panel.grid=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.ticks=element_blank()) + 
  theme(legend.title = element_text(size = 16,  face = "bold")) + 
  theme(legend.text  = element_text(size  = 14,  face = "bold")) 

SNP <- SNP +  geom_label(aes(label=paste(fraction*100,"%"),
                             x=3.5,
                             y=(ymin+ymax)/2),
                         inherit.aes = TRUE, show.legend = FALSE)

SNP <- SNP + 
  
  labs(title = "",
       
       subtitle   = "Michigan Imputation Server",
       caption = paste0( dat$count[dat$category=="Imputed"], "  Imputed"  , "\n",
                         dat$count[dat$category=="Genotyped"] , "  Genotyped" , "\n\n" , 
                         "simultaneous job submissions limit: 3", "\n", "avg cost per sample:  Free" , "\n", "avg runtime: 17min"))

Michigan <- SNP


library(ggplot2)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )



dat = data.frame(count    =c(154683, 30373771), 
                 category =c("Genotyped", "Imputed"))

dat$fraction = round((dat$count / sum(dat$count)), 3)

dat$ymax = cumsum(dat$fraction)
dat$ymin = c(0, head(dat$ymax, n=-1))
dat$category <- factor(dat$category, 
                       levels = c("Genotyped", "Imputed"))


p1 = ggplot(dat, aes(fill=category,
                     ymax=ymax, 
                     ymin=ymin, 
                     xmax=4, 
                     xmin=3)) +
  geom_rect(color= NA) +
  coord_polar(theta="y") +
  xlim(c(1, 4)) 



SNP<-p1 + scale_fill_brewer("SNPs") + blank_theme +
  theme(axis.text.x=element_blank()) +  
  theme(legend.position=c(.5, .5)) + 
  ggtitle("") +
  theme(panel.grid=element_blank()) +
  theme(axis.text=element_blank()) +
  theme(axis.ticks=element_blank()) + 
  theme(legend.title = element_text(size = 16,  face = "bold")) +
  theme(legend.text  = element_text(size  = 14,  face = "bold")) 

SNP <- SNP +  geom_label(aes(label=paste(fraction*100,"%"),
                             x=3.5,
                             y=(ymin+ymax)/2),
                         inherit.aes = TRUE, show.legend = FALSE)

SNP <- SNP + 
  
  labs(title = "",
       
       subtitle   = "Deploit FastImputation™",
       caption = paste0( dat$count[dat$category=="Imputed"], "  Imputed"  , "\n",
                         dat$count[dat$category=="Genotyped"] , "  Genotyped"  , "\n\n" , 
                         "simultaneous job submissions limit: unlimited", "\n", "avg cost per sample: 0.08 $" , "\n", "avg runtime: 11min"))
DeploitFastImpu <- SNP


library(cowplot)

comparativePlot <- plot_grid(Michigan, DeploitFastImpu, 
                             hjust = -0.8,
                             ncol = 2, nrow = 1) +   labs(title = "Imputation method comparison (23andme input file)")


title <- ggdraw() + draw_label("Imputation method comparison (23andme input file)", fontface='bold')
comparativePlot <- plot_grid(title, comparativePlot, ncol=1, rel_heights=c(0.1, 1)) # rel_heights values control title margins

comparativePlot

# 
# 
# png(filename =  paste(pinkpatheR::pinkpatheR(), "imputation_comparison_plot.png"),
#       width = 1000, height = 600,res = 300)
# plot(comparativePlot)
# dev.off()




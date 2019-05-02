# A function to create comparative ring plots with 2 categorical variables
# Description of plot, required input files
# to use the functions in this scripts do:
# source("filepath/to/drawRingplot.R")



drawRingplot <- function(   toPlot ,    
                            categorical_variable = "SNPs",
                            category_1_label     = "Genotyped",
                            category_2_label     = "Imputed",
                            
                            custom_TITLE         = "", 
                            custom_subtitle      =  c("Michigan Imputation Server", 
                                                      "FastImputation by Deploit")[1]){
    
    ###############################################################################
    # A. Loading required packages
    ###############################################################################  

    library(ggplot2)
    library(extrafont)
    library(cowplot)

    
    ###############################################################################
    # B. Loading input data, creating helper variables for axes
    ###############################################################################
    
    # Loading input data
    toPlot = read.csv(FILE, 
                      header           = TRUE, 
                      stringsAsFactors = FALSE, 
                      check.names      = FALSE); 
    
    # Calculating percentage and rounding to first decimal
    toPlot$fraction = round((toPlot$count / sum(toPlot$count)), 3)
    
    # Calculations for optimizing plot limits
    toPlot$ymax_of_data   =  cumsum(toPlot$fraction)
    toPlot$ymin_of_data   =  c(0, head(toPlot$ymax_of_data, n=-1))
    
    # Crating category labels as factors for aes
    toPlot$category <- factor(toPlot$category, 
                              levels = c( category_1_label, category_2_label))
    
    
    ###############################################################################
    # C. Setting theme to white background, stripped down from axes
    ###############################################################################
    
    # define blank theme - to have white background
    blank_theme <- theme_minimal()+ 
      theme(
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.grid=element_blank(),
        axis.ticks = element_blank(),
        plot.title=element_text(size=14,  face="bold"),
        theme(text=element_text(size=16,  family="serif"))
      )
    
    
    ###############################################################################
    # D. Plotting the first layers to create ringplot dra{w,ft}
    ###############################################################################
    ringplot <-  ggplot(toPlot, aes(fill=category,
                         ymax=ymax_of_data, 
                         ymin=ymin_of_data, 
                         xmax=4, 
                         xmin=3)) +
                  
                  # ommit frame around ringplot
                  geom_rect(color = NA) +
                  coord_polar(theta="y") +
                  xlim(c(1, 4)) 
                
    
    
    ###############################################################################
    # E. Removing ggplot-y flavor (aka the teal/coral duo, axis lines) 
    #    making compact (legend in the middle)
    ###############################################################################
    
    minimal_ringplot <- ringplot +  blank_theme +
      theme(axis.text.x=element_blank()) +  
      theme(legend.position=c(.5, .5)) + 
      ggtitle("") +
      theme(panel.grid=element_blank()) +
      theme(axis.text=element_blank()) +
      theme(axis.ticks=element_blank()) + 
      theme(legend.title = element_text(size = 16,  face = "bold")) +
      theme(legend.text  = element_text(size  = 14,  face = "bold")) +
      
      # Careful - this changes category label and not colour (eg. 'SNPs' written inside plot)
      scale_fill_brewer(categorical_variable) 
      
      
    ###############################################################################
    # F. Adding percentage labels in the two categories
    ###############################################################################
    
    minimal_ringplot <- minimal_ringplot +  geom_label(aes(label=paste(fraction*100,"%"),
                                                           x=3.5,
                                                           y=(ymin_of_data+ymax_of_data)/2),
                                                       inherit.aes = TRUE, 
                                                       show.legend = FALSE)
    
    ###############################################################################
    # G. Adding percentage labels in the two categories
    ###############################################################################
    
    minimal_ringplot <- minimal_ringplot + 
      
      labs(title = custom_TITLE,
           
           subtitle   = custom_subtitle,
           caption    = paste0( toPlot$count[dat$category==category_1_label] , "  ", category_1_label  , "\n",
                                toPlot$count[dat$category==category_2_label] , "  ", category_2_label    )  )
    
    return(minimal_ringplot)
    
    ###############################################################################
    # H.End of function ringplot()
    ###############################################################################
    
    
  }









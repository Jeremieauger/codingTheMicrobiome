#
# -- Advances_Statistics_Code_Ratios.R: R code for Explorations in Statistics --
#
library ( beeswarm  )
library ( coin      )
library ( lmodel2   )
library ( smatr     )

par     ( las   = 1          )                                            #  make axis numbers horizontal
par     ( mfrow = c ( 2, 2 ) )                                            #  4 graphics on 1 screen

nPerm.II    <-  10000 - 1                                                 #  number of permutations for model II regression
nPerm.R     <- 100000 - 1                                                 #  number of permutations to compare ratios

Alpha       <-      0.01                                                  #  critical significance level
CI_Level    <-      1 - Alpha                                             #  confidence interval

PopMean     <-      0                                                     #  population mean
PopSD       <-      1                                                     #  population SD


# -- The Trouble with Ratios: an Overview :: Figure 1 --------------------------              # -- Figure 1: first line
#

# -- Define parameters and sample sizes ----------------------------------------
#
uMin        <-      1                                                     #  uniform distribution: minimum
uMax        <-      5                                                     #  uniform distribution: maximum

nObs_2      <-   1000                                                     #  number of observations for Figure 2
Ratio       <- matrix ( nrow = nObs_2, ncol = 6 )

for ( i in 1:nObs_2 )
{ Numer <- rnorm ( 1, mean = PopMean, sd = PopSD ) + ( 5 * PopSD )    #  N~(0,1)
Denom <- rnorm ( 1, mean = PopMean, sd = PopSD ) + ( 5 * PopSD )    #  N~(0,1) ... make sure greater than 0
Ratio [ i, 1 ] <- Numer                                             #  actual response y
Ratio [ i, 2 ] <- Denom                                             #  denominator x
Ratio [ i, 3 ] <- Numer / Denom                                     #  ratio y / x

Numer <- runif ( 1, min = uMin, max = uMax )                        #  uniform~(0,1)
Denom <- runif ( 1, min = uMin, max = uMax )
Ratio [ i, 4 ] <- Numer                                             #  actual response y
Ratio [ i, 5 ] <- Denom                                             #  denominator x
Ratio [ i, 6 ] <- Numer / Denom                                     #  ratio y / x
}


# -- Correlations between actual response y and denominator x ------------
#
cor.test ( Ratio [ , 2 ], Ratio [ , 1 ], method = 'pearson'  )            #  normal distribution
cor.test ( Ratio [ , 5 ], Ratio [ , 4 ], method = 'pearson'  )            #  uniform distribution


#  -- Relationship of ratio y/x to denominator x ------------
#
plot ( Ratio [ , 2 ], Ratio [ , 1 ],                                      #  y vs x: normal distribution
       main       =  paste ( 'Actual y: normal' ),
       xlab       = 'Denominator x',
       ylab       = 'Numerator y',
       frame.plot = FALSE
)
#
plot ( Ratio [ , 2 ], Ratio [ , 3 ],                                      #  y/x vs x: normal distribution
       main       =  paste ( 'Ratio y/x: normal' ),
       xlab       = 'Denominator x',
       ylab       = 'Ratio y/x',
       frame.plot = FALSE
)

plot ( Ratio [ , 5 ], Ratio [ , 4 ],                                      #  y vs x: uniform distribution
       main       =  paste ( 'Actual y: uniform' ),
       xlab       = 'Denominator x',
       ylab       = 'Numerator y',
       frame.plot = FALSE
)
#
plot ( Ratio [ , 5 ], Ratio [ , 6 ],                                      #  y/x vs x: uniform distribution
       main       =  paste ( 'Ratio y/x: uniform' ),
       xlab       = 'Denominator x',
       xlim       =  c ( uMin, uMax ),
       ylab       = 'Ratio y/x',
       frame.plot = FALSE
)
#
Spurious_Correlations_Figure <- recordPlot ( )                            #  store data graphic            # -- Figure 1: last line


# -- The Trouble with Ratios: an Example :: Figure 3 ---------------------------              # -- Figure 3: first line
#
par ( mfrow = c ( 1, 1 ) )                                                #  1 graphic on 1 screen


# -- Read in the data ----------------------------------------------------------
#
X.S   <- c ( 382, 335, 388, 316, 319, 399, 358, 355, 344, 339 )
Y.S   <- c (  66,  72,  84,  47,  75,  87,  75,  73,  59,  70 )
#
Ratio <- Y.S / X.S
round ( mean ( Ratio ), 2 )


# -- Plot the data -------------------------------------------------------------
#
plot ( X.S, Y.S,
       main  = 'Figure 3',
       xlab  = 'Denominator x: feed eaten',
       xlim  = c ( 0, 400 ),
       ylab  = 'Numerator y: weight gain',
       ylim  = c ( 0, 100 ),
       pch   = 19,
       col   = 'black',
       frame = FALSE
)
#
abline ( a   = 0,                                                         #  add line of mean ratio
         b   = mean ( Ratio ),
         col = 'gray50',
         lw  = '2'
)


# -- Ordinary least-squares regression -----------------------------------------
#
OLS_Regression <- lm ( Y.S ~ X.S )
OLS_Regression
#
abline ( OLS_Regression,                                                  #  add ordinary least-squares regression line
         col = 'gray50',
         lw  = '2'
)


# -- Model II regression -------------------------------------------------------
#
Model_II_Snedecor_1946_Pig_Weight <- lmodel2 ( Y.S ~ X.S,
                                               range.y = 'interval',
                                               range.x = 'interval',
                                               nperm   =  nPerm.II
)
#
b0_SMA <- Model_II_Snedecor_1946_Pig_Weight$regression.results$Intercept[ 3 ]
round ( b0_SMA, 2 )
#
b1_SMA <- Model_II_Snedecor_1946_Pig_Weight$regression.results$Slope[ 3 ]
round ( b1_SMA, 2 )
#
abline ( a   = b0_SMA,                                                    #  add model II regression line
         b   = b1_SMA,
         col = 'black',
         lw  = '2'
)

Snedecor_Figure <- recordPlot ( )                                         #  store data graphic            # -- Figure 3: last line


# -- Regression: Another Approach :: Figures 4-7 -------------------------------              # -- Figures 4-7: first line
#
nObs        <-     30                                                     #  number of sample observations for regression examples
nStatistics <-      4                                                     #  number of statistics for regression examples

b0          <-     15                                                     #  non-zero b0

for ( n.Coeff in 1:2  )                                                   #  2 runs: same slopes and different slopes
{ rm ( The_Data, Group_0_Data, Group_1_Data )                         #  clear the data matrices
  
  if ( n.Coeff == 1 ) { b0_0        <-  b0                            #  Group 0: coefficients that define true relationship between Y and X
  b1_0        <-   1
  
  b0_1        <-  b0 + 5                        #  Group 1: coefficients that define true relationship between Y and X
  b1_1        <-   1
  
  b.Text      <- 'b0'
  }
  
  
  if ( n.Coeff == 2 ) { b0_0        <-  b0                            #  Group 0: coefficients that define true relationship between Y and X
  b1_0        <-   1
  
  b0_1        <-  b0                            #  Group 1: coefficients that define true relationship between Y and X
  b1_1        <-   1.25
  
  b.Text      <- 'b1'
  }
  
  
  # -- Generate 2 samples of obs -------------------------------------------------
  #
  The_Data  <- matrix ( nrow = 2 * nObs, ncol = nStatistics )
  
  
  # -- Generate Group 0 observations ---------------------------------------------
  #
  for ( k in 1:nObs )
  { The_Data [ k,1 ] <- 0
  
  X <- k + 100 - ( nObs / 2 )                                                 #  define X
  
  X_Random_Error   <- round ( rnorm ( 1, mean = PopMean, sd = PopSD ), 3 )    #  measurement error in X
  The_Data [ k,2 ] <- X + X_Random_Error                                      #  X value: denominator
  
  Y_Random_Error   <- round ( rnorm ( 1, mean = PopMean, sd = PopSD ), 3 )
  The_Data [ k,3 ] <- b0_0 + ( b1_0 * X ) + Y_Random_Error                    #  Y value: numerator
  }
  
  
  # -- Generate Group 1 observations ---------------------------------------------
  #
  for ( k in ( 1 + nObs ) : ( nObs + nObs ) )
  { The_Data [ k,1 ] <- 1
  
  X <- k + 100 - ( nObs / 2 ) - nObs                                          #  define X
  
  X_Random_Error   <- round ( rnorm ( 1, mean = PopMean, sd = PopSD ), 3 )    #  measurement error in X
  The_Data [ k,2 ] <- X + X_Random_Error                                      #  X value: denominator
  
  Y_Random_Error   <- round ( rnorm ( 1, mean = PopMean, sd = PopSD ), 3 )
  The_Data [ k,3 ] <- b0_1 + ( b1_1 * X ) + Y_Random_Error                    #  Y value: numerator
  }
  
  
  # -- Calculate ratio Y/X -------------------------------------------------------
  #
  The_Data [ ,4 ] <- The_Data [ ,3 ] / The_Data [ ,2 ]
  
  
  # -- Create separate datasets for each group -----------------------------
  #
  Group_0_Data <- subset ( The_Data, The_Data [ ,1 ] == 0 )                 #  Group 0 data
  Group_0_Data
  
  Group_1_Data <- subset ( The_Data, The_Data [ ,1 ] == 1 )                 #  Group 1 data
  Group_1_Data
  
  
  # -- Ratio: plot ratio against denominator X -----------------------------------
  #
  par ( mfrow = c ( 2, 2 ) )
  
  
  xMin <- floor   ( min ( The_Data [ ,2 ] ) )
  xMax <- ceiling ( max ( The_Data [ ,2 ] ) )
  
  yMin <- floor   ( min ( The_Data [ ,3 ] ) )
  yMax <- ceiling ( max ( The_Data [ ,3 ] ) )
  
  rMin <- min ( The_Data [ ,4 ] )
  rMax <- max ( The_Data [ ,4 ] )
  
  plot ( The_Data [ ,2 ] [ The_Data [ ,1 ] == 0 ], The_Data [ ,4 ] [ The_Data [ ,1 ] == 0 ] ,
         main       = paste ( b.Text, '... Group 0: ratio vs X' ),
         xlab       = 'Denominator x',
         xlim       =  c ( xMin, xMax ),
         ylab       = 'Ratio',
         ylim       =  c ( rMin, rMax ),
         pch        = 19,
         col        = 'gray50',
         frame.plot = FALSE,
  )
  abline ( h = mean ( The_Data [ ,4 ] [ The_Data [ ,1 ] == 0 ] ) )
  
  plot ( The_Data [ ,2 ] [ The_Data [ ,1 ] == 1 ], The_Data [ ,4 ] [ The_Data [ ,1 ] == 1 ] ,
         main       = paste ( b.Text, '... Group 1: ratio vs X' ),
         xlab       = 'Denominator x',
         xlim       =  c ( xMin, xMax ),
         ylab       = ' ',
         ylim       =  c ( rMin, rMax ),
         pch        = 19,
         col        = 'black',
         frame.plot = FALSE
  )
  abline ( h = mean ( The_Data [ ,4 ] [ The_Data [ ,1 ] == 1 ] ) )
  
  if ( n.Coeff == 1 ) Ratio_vs_Covariate_X_by_Group_b0 <- recordPlot ( )
  if ( n.Coeff == 2 ) Ratio_vs_Covariate_X_by_Group_b1 <- recordPlot ( )
  
  
  # -- Ratio: plot and compare between groups ------------------------------------
  #
  par ( mfrow = c ( 1, 1 ) )
  
  Group.0.Mean.Ratio <- mean ( Group_0_Data [ ,4 ] )
  Group.1.Mean.Ratio <- mean ( Group_1_Data [ ,4 ] )
  
  beeswarm ( The_Data [ ,4 ] ~ The_Data [ ,1 ],                             #  ratio vs x
             main  =  paste ( 'Difference in', b.Text, '... ratio y/x' ),
             ylab  = 'y/x',
             xlab  = 'Group',
             col   = c ( 'gray50', 'black' ),
             pch   = 19,
             bty   = 'n'
  )
  abline ( h = Group.0.Mean.Ratio )
  abline ( h = Group.1.Mean.Ratio )
  
  if ( n.Coeff == 1 ) Ratio_Scatterplot_b0 <- recordPlot ( )
  if ( n.Coeff == 2 ) Ratio_Scatterplot_b1 <- recordPlot ( )
  
  
  # -- Ratio: t tests and permutation methods ------------------------------------
  #
  if ( n.Coeff == 1 ) t_b0 <- t.test ( The_Data [ ,4 ] ~ The_Data [ ,1 ],
                                       alternative = c ( 'two.sided' ),
                                       var.equal   = FALSE,
                                       conf.level  = CI_Level,
  )
  #
  if ( n.Coeff == 1 ) perm_b0 <- oneway_test ( The_Data [ ,4 ] ~ factor ( The_Data [ ,1 ] ),
                                               distribution = approximate ( B = nPerm.R )
  )
  
  if ( n.Coeff == 2 ) t_b1 <- t.test ( The_Data [ ,4 ] ~ The_Data [ ,1 ],
                                       alternative = c ( 'two.sided' ),
                                       var.equal   = FALSE,
                                       conf.level  = CI_Level,
  )
  #
  if ( n.Coeff == 2 ) perm_b1 <- oneway_test ( The_Data [ ,4 ] ~ factor( The_Data [ ,1 ] ),
                                               distribution = approximate( B = nPerm.R )
  )
  
  
  # -- Plot observations from each group and add model II regression ------------------------------
  #
  par ( mfrow = c ( 1, 1 ) )
  
  plot ( Group_0_Data [ ,2 ], Group_0_Data [ ,3 ],                          #  group 0 data
         main       =  paste ( 'Difference in', b.Text, '... model II regressions' ),
         xlab       = 'Covariate x',
         xlim       =  c ( xMin, xMax ),
         ylab       = 'Actual response y',
         ylim       =  c ( yMin, yMax ),
         pch        = 19,
         col        = 'gray50',
         frame.plot = FALSE
  )
  
  Model_II_Simulation_0 <- lmodel2 ( Group_0_Data [ ,3 ] ~ Group_0_Data [ ,2 ],    # -- y = f ( x )
                                     range.y = 'interval',
                                     range.x = 'interval',
                                     nperm   =  nPerm.II
  )
  #
  Model_II_Simulation_0
  
  Group_0_b0_SMA <- Model_II_Simulation_0$regression.results$Intercept [ 3 ]
  Group_0_b1_SMA <- Model_II_Simulation_0$regression.results$'    Slope' [ 3 ]
  
  Group_0_x1 <- min ( The_Data [ ,2 ] [ The_Data [ ,1 ] == 0 ] )            #  min X for Group 0
  Group_0_y1 <- Group_0_b0_SMA + ( Group_0_b1_SMA * Group_0_x1 )
  
  Group_0_x2 <- max ( The_Data [ ,2 ] [ The_Data [ ,1 ] == 0 ] )            #  min X for Group 0
  Group_0_y2 <- Group_0_b0_SMA + ( Group_0_b1_SMA * Group_0_x2 )
  
  segments(Group_0_x1, Group_0_y1, Group_0_x2, Group_0_y2, col = 'gray50', lw  = '1' )
  
  par ( new = T )
  
  plot ( Group_1_Data [ ,2 ], Group_1_Data [ ,3 ],                          #  group 1 data
         main       =  ' ',
         xlab       = ' ',
         xlim       =  c ( xMin, xMax ),
         ylab       = ' ',
         ylim       =  c ( yMin, yMax ),
         pch        = 19,
         col        = 'black',
         axes       = FALSE,
         frame.plot = FALSE
  )
  #
  par ( new = F )
  
  Model_II_Simulation_1 <- lmodel2 ( Group_1_Data [ ,3 ] ~ Group_1_Data [ ,2 ],    # -- y = f ( x )
                                     range.y = 'interval',
                                     range.x = 'interval',
                                     nperm   =  nPerm.II
  )
  #
  Model_II_Simulation_1
  
  Group_1_b0_SMA <- Model_II_Simulation_1$regression.results$Intercept [ 3 ]
  Group_1_b1_SMA <- Model_II_Simulation_1$regression.results$'    Slope' [ 3 ]
  
  
  # -- Add fitted regression line to plot ----------------------------------------
  #
  Group_1_x1 <- min ( The_Data [ ,2 ] [ The_Data [ ,1 ] == 1 ] )            #  min X for Group 1
  Group_1_y1 <- Group_1_b0_SMA + ( Group_1_b1_SMA * Group_1_x1 )
  
  Group_1_x2 <- max ( The_Data [ ,2 ] [ The_Data [ ,1 ] == 1 ] )            #  min X for Group 1
  Group_1_y2 <- Group_1_b0_SMA + ( Group_1_b1_SMA * Group_1_x2 )
  
  segments ( Group_1_x1, Group_1_y1, Group_1_x2, Group_1_y2, col = 'black', lw  = '1' )
  
  
  # -- Add fitted regression coefficients to plot --------------------------------
  #
  b0_0_SMA <- round ( Group_0_b0_SMA, 2 )
  b1_0_SMA <- round ( Group_0_b1_SMA, 2 )
  
  b0_1_SMA <- round ( Group_1_b0_SMA, 2 )
  b1_1_SMA <- round ( Group_1_b1_SMA, 2 )
  
  text ( x = xMax, y = yMin + 10, paste ( 'Group 0: b0=', b0_0_SMA, ', b1=', b1_0_SMA ), pos = 2 )    #  group 0 label and coeffs
  text ( x = xMin, y = yMax - 10, paste ( 'Group 1: b0=', b0_1_SMA, ', b1=', b1_1_SMA ), pos = 4 )    #  group 1 label and coeffs
  
  if ( n.Coeff == 1 ) Fitted_Regression_Equations_b0 <- recordPlot ( )
  if ( n.Coeff == 2 ) Fitted_Regression_Equations_b1 <- recordPlot ( )
  
  
  # -- Model II regression comparing slopes of the 2 groups ----------------------
  #
  Model_II_Regression_Simulation <- sma ( The_Data [ ,3 ] ~ The_Data [ ,2 ] * The_Data [ ,1 ] )
  Model_II_Regression_Simulation
  #
  summary ( Model_II_Regression_Simulation )
  
  
  # -- Merge residuals with data -------------------------------------------------
  #
  The_Data_and_Residuals <- cbind ( The_Data, fitted ( Model_II_Regression_Simulation ), resid  ( Model_II_Regression_Simulation ) )
  The_Data_and_Residuals
  
  eMin <- floor   ( min ( resid ( Model_II_Regression_Simulation ) ) )
  eMax <- ceiling ( max ( resid ( Model_II_Regression_Simulation ) ) )
  
  
  # -- Plot SMA residuals against covariate x -----------------------------------------------------
  #
  par ( mfrow = c ( 2, 2 ) )
  
  plot ( The_Data_and_Residuals [ ,2 ] [ The_Data_and_Residuals [ ,1 ] == 0 ], The_Data_and_Residuals [ ,6 ] [ The_Data_and_Residuals [ ,1 ] == 0 ],
         main       =  paste ( b.Text, '... Group 0: SMA residuals' ),
         xlab       = 'Covariate x',
         xlim       =  c ( xMin, xMax ),
         ylab       = 'SMA residual',
         ylim       =  c ( eMin, eMax ),
         pch        = 19,
         col        = 'gray50',
         frame.plot = FALSE
  )
  #
  abline ( h   = 0 )
  
  plot ( The_Data_and_Residuals [ ,2 ] [ The_Data_and_Residuals [ ,1 ] == 1 ], The_Data_and_Residuals [ ,6 ] [ The_Data_and_Residuals [ ,1 ] == 1 ],
         main       =  paste ( b.Text, '... Group 1: SMA residuals' ),
         xlab       = 'Covariate x',
         xlim       =  c ( xMin, xMax ),
         ylab       = 'SMA residual',
         ylim       =  c ( eMin, eMax ),
         pch        = 19,
         col        = 'black',
         frame.plot = FALSE
  )
  #
  abline ( h   = 0 )
  
  if ( n.Coeff == 1 ) My_SMA_Residuals_b0 <- recordPlot ( )
  if ( n.Coeff == 2 ) My_SMA_Residuals_b1 <- recordPlot ( )
  
  
  # -- If slopes similar, test for difference in elevation using common slope
  #
  if ( Model_II_Regression_Simulation [ 3 ]$commoncoef$p >= Alpha )         #  if slopes similar then compare elevation
    #
  { Model_II_Regression_Elevation <- sma ( The_Data [ ,3 ] ~ The_Data [ ,2 ] + The_Data [ ,1 ], type = 'elevation' )
  Model_II_Regression_Elevation
  summary ( Model_II_Regression_Elevation )
  }
  
}                                                                     #  end of b0 and b1 loop
# -- Figures 4-7: last line


# -- Replay each data graphic --------------------------------------------------
#
replayPlot ( Spurious_Correlations_Figure   )                             #  Figure 1
replayPlot ( Snedecor_Figure                )                             #  Figure 3


# -- Reprint ratio analyses and replay each data graphic -----------------------
#
t_b0
perm_b0
#
replayPlot ( Ratio_Scatterplot_b0             )                           #  Figure 4
replayPlot ( Fitted_Regression_Equations_b0   )                           #  Figure 5
replayPlot ( Ratio_vs_Covariate_X_by_Group_b0 )                           #  Figure 5 inset
replayPlot ( My_SMA_Residuals_b0              )                           #  Figure 7 top

t_b1
perm_b1
#
replayPlot ( Ratio_Scatterplot_b1             )                           #  no Figure in paper
replayPlot ( Fitted_Regression_Equations_b1   )                           #  Figure 6
replayPlot ( Ratio_vs_Covariate_X_by_Group_b1 )                           #  Figure 6 inset
replayPlot ( My_SMA_Residuals_b1              )                           #  Figure 7 bottom


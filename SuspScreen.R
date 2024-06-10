setwd("C:\\ACES\\R\\method development\\Suspect screening")
library(MSbox)

#Dry condition-AMAPECHA
{
  setwd("C:\\ACES\\R\\method development\\Suspect screening")
  RD=read.csv("Realdry.csv",header=T)
  lib=read.csv("AMAPECHA.csv",header=T)
  
  i <- 1
  j <- 1
  while (i<40927) {
    while (j<598) {
      if (lib[j,3]>(RD[i,2]+0.002)){
        j<- 1
        break}
      else {
        if (RD[i,2]<200) {
          if (RD[i,2]<(lib[j,3]+0.002)&&RD[i,2]>(lib[j,3]-0.002)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,3]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
        else{
          if (RD[i,2]<(lib[j,3]*1.000005)&&RD[i,2]>(lib[j,3]*0.999995)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,3]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
      }
      j <- j+1}
    i <- i+1}
  write.table(RD,"wetECHA.csv",sep=",")
}

#Wet condition-AMAPECHA
{
  setwd("C:\\ACES\\R\\method development\\Suspect screening")
  RD=read.csv("Realwet.csv",header=T)
  lib=read.csv("AMAPECHA.csv",header=T)
  
  i <- 1
  j <- 1
  while (i<36114) {
    while (j<598) {
      if (lib[j,3]>(RD[i,2]+0.002)){
        j<- 1
        break}
      else {
        if (RD[i,2]<200) {
          if (RD[i,2]<(lib[j,4]+0.002)&&RD[i,2]>(lib[j,4]-0.002)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,4]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
        else{
          if (RD[i,2]<(lib[j,4]*1.000005)&&RD[i,2]>(lib[j,4]*0.999995)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,4]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
      }
      j <- j+1}
    i <- i+1}
  write.table(RD,"wetECHA.csv",sep=",")
}

#Dry condition-GCwCCS
{
  setwd("C:\\ACES\\R\\method development\\Suspect screening")
  RD=read.csv("Realdry.csv",header=T)
  lib=read.csv("GCwCCS.csv",header=T)
  
  i <- 1
  j <- 1
  while (i<40927) {
    while (j<1064) {
      if (lib[j,3]>(RD[i,2]+0.002)){
        j<- 1
        break}
      else {
        if (RD[i,2]<200) {
          if (RD[i,2]<(lib[j,3]+0.002)&&RD[i,2]>(lib[j,3]-0.002)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,3]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
        else{
          if (RD[i,2]<(lib[j,3]*1.000005)&&RD[i,2]>(lib[j,3]*0.999995)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,3]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
      }
      j <- j+1}
    i <- i+1}
  write.table(RD,"dryGC.csv",sep=",")
}

#Wet condition-GCwCCS
{
  setwd("C:\\ACES\\R\\method development\\Suspect screening")
  RD=read.csv("Realwet.csv",header=T)
  lib=read.csv("GCwCCS.csv",header=T)
  
  i <- 1
  j <- 1
  while (i<36114) {
    while (j<1064) {
      if (lib[j,3]>(RD[i,2]+0.002)){
        j<- 1
        break}
      else {
        if (RD[i,2]<200) {
          if (RD[i,2]<(lib[j,4]+0.002)&&RD[i,2]>(lib[j,4]-0.002)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,4]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
        else{
          if (RD[i,2]<(lib[j,4]*1.000005)&&RD[i,2]>(lib[j,4]*0.999995)&&
              RD[i,3]<(lib[j,5]*1.07)&&RD[i,3]>(lib[j,5]*0.93)&&
              RD[i,4]<(lib[j,7]+1)&&RD[i,4]>(lib[j,7]-1)) {
            k <- sum(!is.na(RD[i,]))
            RD[i,(k+1)]<- lib [j,2]
            RD[i,(k+2)]<- lib [j,4]
            #RT
            if (RD[i,4]<(lib[j,7]+0.5)&&RD[i,4]>(lib[j,7]-0.5)){
              RD[i,(k+3)]<- lib [j,7]
              RD[i,(k+4)]<- 1
            }
            else{
              RD[i,(k+3)]<- lib [j,7]
              d <- abs(RD[i,4]-lib[j,7])
              RD[i,(k+4)]<- round(((d-0.5)/0.5),2)
            }
            #CCS
            if (lib[j,6]=="Measured"){
              if (RD[i,3]<(lib[j,5]*1.02)&&RD[i,3]>(lib[j,5]*0.98)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                if (RD[i,3]<(lib[j,5]*1.03)&&RD[i,3]>(lib[j,5]*0.97)){
                  RD[i,(k+5)]<- lib [j,5]
                  d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                  RD[i,(k+6)]<- round((d-0.02)/0.01,2)
                }
                else {
                  RD[i,(k+5)]<- lib [j,5]
                  RD[i,(k+6)]<- 0
                }
              }
            }
            else{
              if (RD[i,3]<(lib[j,5]*1.05)&&RD[i,3]>(lib[j,5]*0.95)){
                RD[i,(k+5)]<- lib [j,5]
                RD[i,(k+6)]<- 1
              }
              else{
                RD[i,(k+5)]<- lib [j,5]
                d <- (abs(RD[i,3]-lib[j,5]))/lib[j,5]
                RD[i,(k+6)]<- round((d-0.05)/0.02,2)
              }
            }
          }
        }
      }
      j <- j+1}
    i <- i+1}
  write.table(RD,"wetGC.csv",sep=",")
}
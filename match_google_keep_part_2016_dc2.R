setwd("/depot/cai161/data/Bike_Share_Data/Data_with_speed")

#change#
data <- read.csv('dc_with_speed.csv', header=TRUE, stringsAsFactors = FALSE)

data <- data[grep(".*/2016", data$start_time), ]

nr <- nrow(data)

#change#
dis_mat_full <- read.csv('bike_distance_dc.csv', header=FALSE, na.strings=c("", "NA"), stringsAsFactors = FALSE)
dur_mat_full <- read.csv('bike_duration_dc.csv', header=FALSE, na.strings=c("", "NA"), stringsAsFactors = FALSE)

valid_len <- length(which(!is.na(dis_mat_full[,1])))
dis_mat <- dis_mat_full[1:valid_len,1:valid_len]

dur_mat <- dur_mat_full[1:valid_len,1:valid_len]


output_data <- data
output_data$google_distance <- rep(0,nr)
output_data$google_duration <- rep(0,nr)

for (k in 1:nr){
  if (output_data$start_station_id[k] %in% dis_mat[,1] & output_data$end_station_id[k] %in% dis_mat[1,]){
    i <- which(dis_mat[,1]==output_data$start_station_id[k])
    j <- which(dis_mat[1,]==output_data$end_station_id[k])
    output_data$google_distance[k] <- dis_mat[i,j]
    output_data$google_duration[k] <- dur_mat[i,j]
  } else {
    output_data$google_distance[k] <- NA
    output_data$google_duration[k] <- NA
  }
}

#change#
sub_data <- output_data[,c("duration","start_time", "m_distance", "google_distance",
                         "google_duration")]
#change#
write.csv(sub_data, file="dc_subset2016_2.csv", row.names=FALSE)



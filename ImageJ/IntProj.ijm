mainDir = getDirectory("Choose a main directory "); 
mainList = getFileList(mainDir); 



setBatchMode(true);

for (i=0; i< mainList.length; i++) {  // for loop to parse through names in main folder 
     if(endsWith(mainList[i], "/")){   // if the name is a subfolder... 

          subDir = mainDir + mainList[i]; 
          subList = getFileList(subDir); 
                    output_dir = subDir + "IntensityProjection" + File.separator ;
          output_dir2 = subDir + "RGBs" + File.separator ;
          File.makeDirectory(output_dir);
          File.makeDirectory(output_dir2);


           for (j=0; j<subList.length; j++) {  // for loop to parse through names in subfolder 
				showProgress(i+1, subList.length);
				open(subDir+subList[j]);
				run("Z Project...", "stop=100 projection=[Max Intensity]");
				saveAs("tif", output_dir+subList[j]);
				run("RGB Color");
				saveAs("tif", output_dir2 +subList[j]);
				run("Close All");
           }          
     }
}
     
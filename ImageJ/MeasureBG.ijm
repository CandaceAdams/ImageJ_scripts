
dir2 = getDirectory("Select projections")
fileList2 = getFileList(dir2);

output_dir2 = dir2 + "Measurements" + File.separator ;
File.makeDirectory(output_dir2)
// prepare a folder to output the images
//output_dir2 = dir2 + File.separator + "Maxima counts" + File.separator ;
//File.makeDirectory(output_dir2);

//activate batch mode
setBatchMode(true);

// LOOP to process the list of files
for (i = 0; i < lengthOf(fileList2); i++) {
	// define the "path" by concatenation of dir and the i element of the array fileList
	current_imagePath = dir2+fileList2[i];
	open(current_imagePath);
	currentImage_name = getTitle();
	//run("Find Maxima...", "prominence=1500 output=Count");
	//getStatistics(area, mean, min, max, std, histogram);
	run("Measure");
	run("Close All");

}
saveAs("results", output_dir2 + "measures.csv");
selectWindow("Results"); 
run("Close");

setBatchMode(false)
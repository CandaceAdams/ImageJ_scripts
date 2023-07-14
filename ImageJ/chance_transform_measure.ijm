// This script will read in raw tiff files, Z project and measure the intensity and location of puncta. Channel 2 images will be transformed and the location of puncta measured to determine the levels of chance coincidence.
// BEFORE YOU START, INPUT CORRECT PROMINENCE LEVELS AS DETERMINED FROM RAW IMAGES


//User selection of directories
dir1 = getDirectory("Choose source directory for channel 1");
dir2 = getDirectory("Choose destination directory for channel 1");
list = getFileList(dir1);

dir3 = getDirectory("Choose source directory for channel 2");
dir4 = getDirectory("Choose destination directory for channel 2");
list1 = getFileList(dir3);

dir5 = getDirectory("Choose destination directory for channel 2 transformed images");
dir6 = getDirectory("Choose destination directory for channel 2 transformed results");
list3 = getFileList(dir5);

setBatchMode(true);

//Measure puncta locations in channel 1
for (j=0; j<list.length; j++) {
	showProgress(j+1, list.length);
	open(dir1+list[j]);
	run("Clear Results");
	run("Z Project...", "start=0 projection=[Average Intensity]"); // "Average Intensity", "Max Intensity", "Standard Deviation" etc.

	run("Find Maxima...", "prominence=100 output=[Point Selection]"); // SET AS CHANNEL 1 PROMINENCE
	run("Measure");

	saveAs("Results",  dir2+list[j]+"_results.csv");

	close();
}


//Measure puncta location in channel 2
for (j=0; j<list1.length; j++) {
	showProgress(j+1, list1.length);
	open(dir3+list1[j]);
	run("Clear Results");
	run("Z Project...", "start=0 projection=[Average Intensity]"); // "Average Intensity", "Max Intensity", "Standard Deviation" etc.

	run("Find Maxima...", "prominence=9000 output=[Point Selection]"); // SET AS CHANNEL 2 PROMINENCE
	run("Measure");

	saveAs("Results",  dir4+list1[j]+"_results.csv");

	close();
}


//Transform channel 2 images
for (i=0; i<list1.length; i++) {
	showProgress(i+1, list1.length);
	open(dir3+list1[i]);
	run("Rotate... ", "angle=180 grid=1 interpolation=None");
	run("Translate...", "x=50 y=0 interpolation=None stack");
	saveAs("tif",  dir5+list1[i]+"_results.csv");
	close();
}


//Measure puncta locations in channel 2 transformed images
setBatchMode(true);
for (j=0; j<list3.length; j++) {
	showProgress(j+1, list3.length);
	open(dir5+list3[j]);
	run("Clear Results");
	run("Z Project...", "projection=[Average Intensity]"); // "Average Intensity", "Max Intensity", "Standard Deviation" etc.

	run("Find Maxima...", "prominence=9000 output=[Point Selection]"); // SET AS CHANNEL 2 PROMINENCE
	run("Measure");

	saveAs("Results",  dir6+list3[j]+"_results.csv");

	close();
}
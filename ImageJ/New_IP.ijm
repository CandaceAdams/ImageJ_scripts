

dir = getDirectory("Choose images file ");

list1 = getFileList(dir);
output_dir = dir + "IntensityProjection" + File.separator ;
output_dir2 = dir + "RGBs" + File.separator ;
File.makeDirectory(output_dir);
File.makeDirectory(output_dir2);
setBatchMode(true);

for (i=0; i<list1.length; i++) {
	showProgress(i+1, list1.length);
	open(dir+list1[i]);
	run("Z Project...", "stop=100 projection=[Max Intensity]");
	saveAs("tif", output_dir+list1[i]);
	run("RGB Color");
	saveAs("tif", output_dir2 +list1[i]);
	run("Close All");

	}
setBatchMode(false);

imagepath=getDirectory("selectimagefolder");
imagelist=getFileList(imagepath);
//sstfolder=File.makeDirectory(imagepath+"sst");
setBatchMode("show");
for (i = 0; i < imagelist.length; i++) {
	file=imagelist[i];
	print(file);
	split_channels(imagepath,file);
	processimage(file);
	savepath=imagepath+File.separator+file;
	run("Read and Write Excel",savepath);
	
}

setBatchMode("show");
print("done")

function split_channels(imagepath,file) { 
// function description
// add a line that will check for .tif images
	open(imagepath+File.separator+file);
	getDimensions(width, height, channels, slices, frames);
	print(channels);
	if (channels ==3) {
		run("Split Channels");
	}
		else {
			print("only"+channels +"in image");
		}
}

function pv_count() { 
// function description
	selectWindow("pv");
	run("Duplicate...");
	run("Gaussian Blur...", "sigma=2");
	run("Auto Threshold", "method=Triangle ignore_black ignore_white white");
	run("Despeckle");
	run("Open");
	setOption("BlackBackground", true);
	run("Erode");
	run("Fill Holes");
	run("Erode");
	run("Fill Holes");
	run("Dilate");
	run("Close-");
	run("Fill Holes");
	run("Close-");
	run("Erode");
	run("Analyze Particles...", "size=38-Infinity circularity=0.20-1.00 show=[Bare Outlines] display exclude clear add");
}
function sst_count() { 
// function description
	selectWindow("sst");
	run("Duplicate...");
	run("Minimum...", "radius=2");
	run("Auto Threshold", "method=Triangle ignore_black ignore_white white");
	run("Analyze Particles...", "size=31-216 circularity=0.2-1.00 show=[Bare Outlines] display exclude clear add");
}

function split_channels(imagepath,file) { 
// function description
// add a line that will check for .tif images
	open(imagepath+File.separator+file);
	getDimensions(width, height, channels, slices, frames);
	print(channels);
	if (channels ==3) {
		run("Split Channels");
	}
		else {
			print("only"+channels +"in image");
		}
}

function processimage(file) { 

	if (indexOf(file, "SST")>=0) {
		renamesst();
		sst_count();
	}
	if (indexOf(file, "PV")>=0) {
		renamepv();
		pv_count();
	}
}
function renamepv() { 
// function description

	windowlist=getList("image.titles");
	for (i = 0; i < windowlist.length; i++) {
	
		if (substring(windowlist[i], 0, 2)=="C2") {
			selectWindow(windowlist[i]);
			print(windowlist[i]);
			rename("grpr");
			}
		if (substring(windowlist[i], 0, 2)=="C1") {
			selectWindow(windowlist[i]);
			print(windowlist[i]);
			rename("pv");
			}
		if (substring(windowlist[i], 0, 2)=="C3") {
			selectWindow(windowlist[i]);
			print(windowlist[i]);
			rename("neun");
		}
	}
}
function renamesst() { 
// function description
	windowlist=getList("image.titles");
	for (i = 0; i < windowlist.length; i++) {

		if (substring(windowlist[i], 0, 2)=="C2") {
			selectWindow(windowlist[i]);
			print(windowlist[i]);
			rename("sst");
			}
		if (substring(windowlist[i], 0, 2)=="C1") {
			selectWindow(windowlist[i]);
			print(windowlist[i]);
			rename("grpr");
			}
		if (substring(windowlist[i], 0, 2)=="C3") {
			selectWindow(windowlist[i]);
			print(windowlist[i]);
			rename("neun");
		}
	}
}

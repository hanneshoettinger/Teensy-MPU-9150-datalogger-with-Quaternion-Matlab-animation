function demo_edgeLines
%DEMO_EDGELINES Demo of the detection/deletion/selection of lines in edge maps.

inputFileName = selectFileToOpen('Select image file', 'png', '');
image = imread(inputFileName);
edgeMap = edge(rgb2gray(image), 'canny', .27, 3);

edgeMap2 = removeEdgeLines(edgeMap);
edgeMap3 = keepEdgeLines(edgeMap);

figure(); imshow(edgeMap);
figure(); imshow(edgeMap2);
figure(); imshow(edgeMap3);

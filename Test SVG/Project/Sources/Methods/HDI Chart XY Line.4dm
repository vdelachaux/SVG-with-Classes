//%attributes = {}

var $chart:=cs:C1710.svgx.chart.new()\
.title("Example lineChart01")

var $X:=[0; 100; 200; 300; 400; 500]


var $serie1:={\
values: [[0; 50]; [100; 100]; [200; 250]; [300; 300]; [400; 480]; [500; 200]]; \
/* Fixed color */color: "blue"\
}

var $serie2:={\
values: [[0; 100]; [100; 50]; [200; 250]; [300; 250]; [400; 100]; [500; 50]]\
}

var $serie3:={\
values: [[0; 400]; [100; 800]; [200; 300]; [300; 500]; [400; 100]; [500; 100]; [600; 500]]\
}

var $serie4:={\
values: [[100; 200]; [200; 500]; [300; 350]; [400; 50]; [500; 80]; [600; 100]]\
}

$chart.xy("myGraph"; {data: [$serie1; $serie2; $serie3; $serie4]; axis: True:C214})

$chart.preview()


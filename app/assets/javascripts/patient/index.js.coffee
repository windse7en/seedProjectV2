polarData = [
    {
        value: 3,
        color: "#a3e1d4",
        highlight: "#1ab394",
        label: "Done"
    },
    {
        value: 7,
        color: "#b5b8cf",
        highlight: "#1ab394",
        label: "Need"
    }
]

polarOptions = {
    scaleShowLabelBackdrop: true,
    scaleBackdropColor: "rgba(255,255,255,0.75)",
    scaleBeginAtZero: true,
    scaleBackdropPaddingY: 1,
    scaleBackdropPaddingX: 1,
    scaleShowLine: true,
    segmentShowStroke: true,
    segmentStrokeColor: "#fff",
    segmentStrokeWidth: 2,
    animationSteps: 100,
    animationEasing: "easeOutBounce",
    animateRotate: true,
    animateScale: false,
}

lineData = {
    labels: gon.score_histories.month,
    datasets: [
        {
            label: "Example dataset",
            fillColor: "rgba(26,179,148,0.5)",
            strokeColor: "rgba(26,179,148,0.7)",
            pointColor: "rgba(26,179,148,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(26,179,148,1)",
            data: gon.score_histories.data
        }
    ]
}

lineOptions = {
    scaleShowGridLines: true,
    scaleGridLineColor: "rgba(0,0,0,.05)",
    scaleGridLineWidth: 1,
    bezierCurve: true,
    bezierCurveTension: 0.4,
    pointDot: true,
    pointDotRadius: 4,
    pointDotStrokeWidth: 1,
    pointHitDetectionRadius: 20,
    datasetStroke: true,
    datasetStrokeWidth: 2,
    datasetFill: true,
    responsive: true,
}
doughnutData = [
    {
        value: 7,
        color: "#a3e1d4",
        highlight: "#1ab394",
        label: "Done"
    },
    {
        value: 3,
        color: "#b5b8cf",
        highlight: "#1ab394",
        label: "Need"
    }
]

doughnutOptions = {
    segmentShowStroke: true,
    segmentStrokeColor: "#fff",
    segmentStrokeWidth: 2,
    percentageInnerCutout: 45, 
    animationSteps: 100,
    animationEasing: "easeOutBounce",
    animateRotate: true,
    animateScale: false,
}

if(typeof(gon.vitals)=='undefined') 
    gon.vitals = []
    console.log("no vitals loaded")

radarData = {
    labels: ["Air Quality", "Sugar Intake", "Calories Intake", "Fat Intake", "Exercise", "Smoke", "Alcohol"],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [90, 60, 70, 75, 60, 55, 45]
        },
        {
            label: "My Second dataset",
            fillColor: "rgba(26,179,148,0.2)",
            strokeColor: "rgba(26,179,148,1)",
            pointColor: "rgba(26,179,148,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: gon.vitals
        }
    ]
}

radarOptions = {
    scaleShowLine: true,
    angleShowLineOut: true,
    scaleShowLabels: false,
    scaleBeginAtZero: true,
    angleLineColor: "rgba(0,0,0,.1)",
    angleLineWidth: 1,
    pointLabelFontFamily: "'Arial'",
    pointLabelFontStyle: "normal",
    pointLabelFontSize: 10,
    pointLabelFontColor: "#666",
    pointDot: true,
    pointDotRadius: 3,
    pointDotStrokeWidth: 1,
    pointHitDetectionRadius: 20,
    datasetStroke: true,
    datasetStrokeWidth: 2,
    datasetFill: true,
    responsive: true,
}

ctx = document.getElementById("radarChart").getContext("2d");
myNewChart = new Chart(ctx).Radar(radarData, radarOptions);
ctx = document.getElementById("polarChart").getContext("2d")
Polarchart = new Chart(ctx).PolarArea(polarData, polarOptions)
ctx = document.getElementById("lineChart").getContext("2d")
myNewChart = new Chart(ctx).Line(lineData, lineOptions)
ctx = document.getElementById("doughnutChart").getContext("2d");
DoughnutChart = new Chart(ctx).Doughnut(doughnutData, doughnutOptions);


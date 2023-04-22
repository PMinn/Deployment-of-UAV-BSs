const points = [];
const velocity2 = 5; // velocity squared
const canvas = document.getElementById('loading');
const context = canvas.getContext('2d');
const radius = 5;
const boundaryX = 200;
const boundaryY = 200;
const numberOfPoints = 30;
const circleColor = '#2F5A91';
const lineColor = '#2F5A91';
var animationFrame;
init();

function init() {
    for (var i = 0; i < numberOfPoints; i++) createPoint();
    for (var i = 0; i < points.length; i++) {
        if (i == 0) points[i].buddy = points[points.length - 1];
        else points[i].buddy = points[i - 1];
    }
}

function createPoint() {
    var point = {}, vx2, vy2;
    point.x = Math.random() * boundaryX;
    point.y = Math.random() * boundaryY;
    point.vx = (Math.floor(Math.random()) * 2 - 1) * Math.random();
    vx2 = Math.pow(point.vx, 2);
    vy2 = velocity2 - vx2;
    point.vy = Math.sqrt(vy2) * (Math.random() * 2 - 1);
    points.push(point);
}

function resetVelocity(point, axis, dir) {
    if (axis == 'x') {
        point.vx = dir * Math.random();
        vx2 = Math.pow(point.vx, 2);
        vy2 = velocity2 - vx2;
        point.vy = Math.sqrt(vy2) * (Math.random() * 2 - 1);
    } else {
        point.vy = dir * Math.random();
        vy2 = Math.pow(point.vy, 2);
        vx2 = velocity2 - vy2;
        point.vx = Math.sqrt(vx2) * (Math.random() * 2 - 1);
    }
}

function drawCircle(x, y) {
    context.beginPath();
    context.arc(x, y, radius, 0, 2 * Math.PI, false);
    context.fillStyle = circleColor;
    context.fill();
}

function drawLine(x1, y1, x2, y2) {
    context.beginPath();
    context.moveTo(x1, y1);
    context.lineTo(x2, y2);
    context.strokeStyle = lineColor;
    context.stroke();
}

function draw() {
    for (var i = 0, l = points.length; i < l; i++) {
        var point = points[i];
        point.x += point.vx;
        point.y += point.vy;
        drawCircle(point.x, point.y);
        drawLine(point.x, point.y, point.buddy.x, point.buddy.y);
        if (point.x < 0 + radius) {
            resetVelocity(point, 'x', 1);
        } else if (point.x > boundaryX - radius) {
            resetVelocity(point, 'x', -1);
        } else if (point.y < 0 + radius) {
            resetVelocity(point, 'y', 1);
        } else if (point.y > boundaryY - radius) {
            resetVelocity(point, 'y', -1);
        }
    }
}

function animate() {
    context.clearRect(0, 0, boundaryX, boundaryY);
    draw();
    animationFrame = requestAnimationFrame(animate);
}


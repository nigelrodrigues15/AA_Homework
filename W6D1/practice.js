document.addEventListener("DOMContentLoaded", function(){
  const canvasEl = document.getElementById("mycanvas");
  canvasEl.width = 400;
  canvasEl.height = 400;

  const ctx = canvasEl.getContext("2d");
  ctx.fillStyle = "blue";
  ctx.fillRect(0, 0, 500, 500);

  ctx.beginPath();
  ctx.arc(200, 200, 50, 0, 2*Math.PI, true);

  ctx.strokeStyle = "black";
  ctx.lineWidth = 5;
  ctx.stroke();

  ctx.fillStyle = "red";
  ctx.fill();
  
});

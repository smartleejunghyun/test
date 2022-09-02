<!DOCTYPE html>

<html lang="KR">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
<style>
.item1{
  width: 469px;
  height: 38px;
  margin: 15px 0 16px 47px;
  padding: 0 400px 0 0;
  border-radius: 10px;
  background-color: #fbb03b;
  display:inline-block;
  color:black;
}

input {
	border: none;
	border-right: 0px;
	border-bottom: 0px;
	border-left: 0px;
	border-top: 0px
}
</style>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="Main2.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<script src="Main.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Document</title>

</head>


<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Navbar</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							Dropdown </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Action</a></li>
							<li><a class="dropdown-item" href="#">Another action</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Something else
									here</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link disabled">Disabled</a>
					</li>
				</ul>
				<button class="btn-success" type="submit">로그인</button>
				<a href="Join.jsp"><button class="btn-success">회원가입</button></a>
			</div>
		</div>
	</nav>
	<script class="jsbin"
		src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
	<div class="file-upload">
		<button class="file-upload-btn" type="button"
			onclick="$('.file-upload-input').trigger( 'click' )">Add
			Image</button>

		<div class="image-upload-wrap">
			<input class="file-upload-input" type='file'
				onchange="readURL(this);init().then(()=>predict());" accept="image/*" />
			<div class="drag-text">
				<h3>Drag and drop a file or select add Image</h3>
			</div>
		</div>
		<div class="file-upload-content" style="width: 100px height:100px;">
			<img class="file-upload-image" load="init()" style="width: 200px; height: 200px;"
				id="face-image" src="#" alt="your image" />
			<div class="image-title-wrap">
				<button type="button" onclick="removeUpload()" class="remove-image">
					Remove <span class="image-title">Uploaded Image</span>
				</button>
			</div>
		</div>
		<div id="itembox"></div>

	</div>

	<!-- <button type="button" onclick="init()">Start</button> -->
	<div id="webcam-container"></div>
	<div style="text-align:center;"id="label-container"></div>
	<script
		src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
	<script type="text/javascript">
		// More API functions here:
		// https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image

		// the link to your model provided by Teachable Machine export panel
		const URL = "https://teachablemachine.withgoogle.com/models/SO6NEweB3/";

		let model, labelContainer, maxPredictions;

		// Load the image model and setup the webcam
		async function init() {
			const modelURL = URL + "model.json";
			const metadataURL = URL + "metadata.json";

			// load the model and metadata
			// Refer to tmImage.loadFromFiles() in the API to support files from a file picker
			// or files from your local hard drive
			// Note: the pose library adds "tmImage" object to your window (window.tmImage)
			model = await
			tmImage.load(modelURL, metadataURL);
			maxPredictions = model.getTotalClasses();

			// Convenience function to setup a webcam
			const flip = true; // whether to flip the webcam

			// append elements to the DOM

			labelContainer = document.getElementById("label-container");
			for (let i = 0; i < maxPredictions; i++) { // and class labels
				labelContainer.appendChild(document.createElement("div"));
			}
		}

		// run the webcam image through the image model
		async function predict() {
			// predict can take in an image, video or canvas html element
			var image = document.getElementById("face-image");
			const prediction = await model.predict(image, false);
			prediction.sort((a, b)=>parseFloat(b.probability) - parseFloat(a.probability))
			const itembox = document.getElementById("itembox");
			
			let typebox = document.getElementById("result");
			let max = 0;
			let type;
			for (let i = 0; i < maxPredictions; i++) {
				let gage = prediction[i].probability.toFixed(2) * 100;
				let classPrediction = prediction[i].className + ": " + gage;
				type = prediction[i].className
				if (max <= gage) {
					$('input[name=result]').attr('value', type)

				}
				labelContainer.childNodes[i].innerHTML = classPrediction;
				$('#label-container > div:nth-child('+i+')').attr('class', 'item'+i)
				$('#label-container > div:nth-child('+i+')').attr('width', 100)
				
			}

		}
	</script>
	<input type="hidden" id='result' name='result' value='사람'>
</body>

</html>
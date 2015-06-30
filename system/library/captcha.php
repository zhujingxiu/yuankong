<?php
class Captcha {
	protected $code;
	protected $width = 35;
	protected $height = 150;
	protected $length = 6;

	function __construct($length=6,$width=35,$height=150) { 
		$this->length = $length;
		$this->width = $width;
		$this->height = $height;
		$this->code = substr(sha1(mt_rand()), 17, $this->length); 
	}

	function getCode(){
		return $this->code;
	}

	function showImage() {
        $image = imagecreatetruecolor($this->height, $this->width);

        $width = imagesx($image); 
        $height = imagesy($image);
		
        $black = imagecolorallocate($image, 0, 0, 0); 
        $white = imagecolorallocate($image, 255, 255, 255); 
        $red = imagecolorallocatealpha($image, 255, 0, 0, 75); 
        $green = imagecolorallocatealpha($image, 0, 255, 0, 75); 
        $blue = imagecolorallocatealpha($image, 0, 0, 255, 75); 
         
        imagefilledrectangle($image, 0, 0, $width, $height, $white); 
         
        imagefilledellipse($image, ceil(rand(5, 145)), ceil(rand(0, 35)), 30, 30, $red); 
        imagefilledellipse($image, ceil(rand(5, 145)), ceil(rand(0, 35)), 30, 30, $green); 
        imagefilledellipse($image, ceil(rand(5, 145)), ceil(rand(0, 35)), 30, 30, $blue); 

        imagefilledrectangle($image, 0, 0, $width, 0, $white); 
        imagefilledrectangle($image, $width - 1, 0, $width - 1, $height - 1, $white); 
        imagefilledrectangle($image, 0, 0, 0, $height - 1, $white); 
        imagefilledrectangle($image, 0, $height - 1, $width, $height - 1, $white); 
         
        imagestring($image, 10, intval(($width - (strlen($this->code) * 9)) / 2),  intval(($height - 15) / 2), $this->code, $black);
	
		header('Content-type: image/jpeg');
		
		imagejpeg($image);
		
		imagedestroy($image);		
	}
}
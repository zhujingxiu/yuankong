<?php
class ModelToolImage extends Model {
	public function resize($filename, $width=100, $height=100,$fullpath=false) {
		$filename = trim($filename);
		if($fullpath){
			if((!file_exists($filename) || !is_file($filename))){
				return;
			}
		}else if (!is_file(DIR_IMAGE . $filename)) {
			return;
		}

		if($fullpath){
			$old_image = $filename;
			$filename = 'other/'.basename($filename);
		}else{
			$old_image = DIR_IMAGE.$filename;
		}

		$extension = pathinfo($filename, PATHINFO_EXTENSION);

		$new_image = 'cache/' . utf8_substr($filename, 0, utf8_strrpos($filename, '.')) . '-' . $width . 'x' . $height . '.' . $extension;

		if (!is_file(DIR_IMAGE . $new_image) || (filectime( $old_image) > filectime(DIR_IMAGE . $new_image))) {
			$path = '';

			$directories = explode('/', dirname(str_replace('../', '', $new_image)));

			foreach ($directories as $directory) {
				$path = $path . '/' . $directory;

				if (!is_dir(DIR_IMAGE . $path)) {
					@mkdir(DIR_IMAGE . $path, 0777);
				}
			}

			list($width_orig, $height_orig) = getimagesize( $old_image);

			if ($width_orig != $width || $height_orig != $height) {
				$image = new Image($old_image);
				$image->resize($width, $height);
				$image->save(DIR_IMAGE . $new_image);
			} else {
				copy($old_image, DIR_IMAGE . $new_image);
			}
		}

		if (isset($this->request->server['HTTPS']) && strtolower($this->request->server['HTTPS']) == 'on') {
			return HTTPS_CATALOG . TPL_IMG . $new_image;
		} else {
			return HTTP_CATALOG . TPL_IMG . $new_image;
		}
	}
}
/**
 * @license Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For the complete reference:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config
	config.filebrowserWindowWidth = '800';
	config.filebrowserWindowHeight = '500';
    config.fillEmptyBlocks = false;
	config.resize_enabled = false;
	config.htmlEncodeOutput = false;
	config.entities = false;
	config.extraPlugins = 'codemirror';
	config.codemirror_theme = 'rubyblue';
	config.toolbar = 'Custom';
	
	config.toolbar_Custom = [
		['Source'],
		['Maximize'],
		['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
		['NumberedList','BulletedList','-','Outdent','Indent'],
		['JustifyLeft','JustifyCenter','JustifyRight','JustifyFull'],
		['SpecialChar'],
		'/',
		['Undo','Redo'],
		['Font','FontSize'],
		['TextColor','BGColor'],
		['Link','Unlink','Anchor'],
		['Image','Table','HorizontalRule']
	];
	config.ignoreEmptyParagraph = false;
	config.protectedSource.push( /<\?[\s\S]*?\?>/g ) ; // PHP style server side code
    config.protectedSource.push(/<a[^>]><\/a>/g);
    config.protectedSource.push(/<i[^>]><\/i>/g);
    config.protectedSource.push(/<em[^>]><\/em>/g);
    config.protectedSource.push(/<b[^>]><\/b>/g);
    config.protectedSource.push(/<span[^>]><\/span>/g);
    config.protectedSource.push(/<p[^>]><\/p>/g);
    config.protectedSource.push(/<strong[^>]><\/strong>/g);
    config.protectedSource.push(/<img[^>]><\/?>/g);
    config.protectedSource.push(/<br[^>]><\/?>/g);
    config.protectedSource.push(/<sup[^>]><\/sup>/g);
    config.protectedSource.push(/<cite[^>]><\/cite>/g);
    config.protectedSource.push(/<code[^>]><\/code>/g);
    config.protectedSource.push(/<pre[^>]><\/pre>/g);
    config.protectedSource.push(/<blockquote[^>]><\/blockquote>/g);
    config.protectedSource.push(/<strike[^>]><\/strike>/g);

    CKEDITOR.dtd.$removeEmpty['a'] = false;
    CKEDITOR.dtd.$removeEmpty['i'] = false;
    CKEDITOR.dtd.$removeEmpty['em'] = false;
    CKEDITOR.dtd.$removeEmpty['b'] = false;
    CKEDITOR.dtd.$removeEmpty['p'] = false;
    CKEDITOR.dtd.$removeEmpty['br'] = false;
    CKEDITOR.dtd.$removeEmpty['img'] = false;
    CKEDITOR.dtd.$removeEmpty['sup'] = false;
    CKEDITOR.dtd.$removeEmpty['cite'] = false;
    CKEDITOR.dtd.$removeEmpty['code'] = false;
    CKEDITOR.dtd.$removeEmpty['span'] = false;
    CKEDITOR.dtd.$removeEmpty['div'] = false;
    CKEDITOR.dtd.$removeEmpty['pre'] = false;
    CKEDITOR.dtd.$removeEmpty['strike'] = false;
    CKEDITOR.dtd.$removeEmpty['blockquote'] = false;

    config.allowedContent = true;
};

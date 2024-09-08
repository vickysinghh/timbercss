/*============================================================================
	Shopify Timber
	Copyright 2015 Shopify Inc.
	Author Carson Shold @cshold
	Built with Sass - http://sass-lang.com/

	Some things to know about this file:
		- Sass is compiled on Shopify's server so you don't need to convert it to CSS yourself
		- The output CSS is compressed and comments are removed
		- You cannot use @imports in this file
				* Use grunt or gulp tasks to enable @imports - https://github.com/Shopify/shopify-css-import
		- Helpers variables, mixins, and starter classes are provided. Change as needed.
		- The file is prepped with a CSS reset
		- The font icons are prepared using https://icomoon.io/app
==============================================================================*/

/*============================================================================
	Table of Contents

	#Breakpoint and Grid Variables
	#General Variables
	#Sass Mixins
	#Normalize
	#Grid Setup
	#Basic Styles
	#Helper Classes
	#Typography
	#Rich Text Editor
	#Links and Buttons
	#Lists
	#Tables
	#Reponsive Tables
	#OOCSS Media Object
	#Images and Iframes
	#Forms
	#Icons
	#Pagination
	#Site Header
	#Site Nav and Dropdowns
	#Mobile Nav
	#Drawers
	#Site Footer
	#Index page
	#Sidebar
	#Product and Collection Grids
	#Collection Filters
	#Breadcrumbs
	#Product Page
	#Blogs Page
	#Notes and Form Feedback
	#Cart Page
	#Wishlist Page
	#Contact Page
	#Ajax Cart Styles
	#theme style
==============================================================================*/

/*============================================================================
	#Breakpoint and Grid Variables
==============================================================================*/
$viewportIncrement: 1px;

$small: 480px;
$medium: 768px;
$large: 769px;

$postSmall: $small + $viewportIncrement;
$preMedium: $medium - $viewportIncrement;
$preLarge: $large - $viewportIncrement;

/*================ The following are dependencies of csswizardry grid ================*/
$breakpoints: (
	'small' '(max-width: #{$small})',
	'medium' '(min-width: #{$postSmall}) and (max-width: #{$medium})',
	'medium-down' '(max-width: #{$medium})',
	'large' '(min-width: #{$large})'
);
$breakpoint-has-widths: ('small', 'medium', 'medium-down', 'large');
$breakpoint-has-push:  ('medium', 'medium-down', 'large');
$breakpoint-has-pull:  ('medium', 'medium-down', 'large');


/*============================================================================
  #General Variables
==============================================================================*/

// Timber Colors
$colorPrimary: #fff;
$colorSecondary: #fff;

$colorDefault: #fff;
$colorSubNav: #fff;
$colorSubNavText: #fff;

// Button colors
$colorBtnPrimary: $colorPrimary;
$colorBtnPrimaryHover: darken($colorBtnPrimary, 10%);
$colorBtnPrimaryActive: darken($colorBtnPrimaryHover, 10%);
$colorBtnPrimaryText: #fff;

$colorBtnSecondary: $colorSecondary;
$colorBtnSecondaryHover: darken($colorBtnSecondary, 10%);
$colorBtnSecondaryActive: darken($colorBtnSecondaryHover, 10%);
$colorBtnSecondaryText: #fff;

// Text link colors
$colorLink: $colorPrimary;
$colorLinkHover: lighten($colorPrimary, 15%);

// Text colors
$colorTextBody: #fff;

// Backgrounds
$colorBody: #fff;

// Border colors
$colorBorder: #fff;

// Nav and dropdown link background
$colorNav: #f2f2f2;
$colorNavText: #333;

// Site Footer
$colorFooterBg: #fff;
$colorFooterText: #fff;

// Logo max width
$logoMaxWidth: {{ 450 | default: '450' | remove: 'px' }}px;

// Helper colors
$disabledGrey: #f6f6f6;
$disabledBorder: darken($disabledGrey, 25%);
$errorRed: #d02e2e;
$errorRedBg: #fff6f6;
$successGreen: #56ad6a;
$successGreenBg: #ecfef0;

// Drawers
$drawerNavWidth: 300px;
$drawerCartWidth: 300px;
$colorDrawers: #f6f6f6;
$colorDrawerBorder: darken($colorDrawers, 5%);
$colorDrawerText: #333;
$drawerTransition: all 0.4s cubic-bezier(0.46, 0.01, 0.32, 1);

// Sizing variables
$siteWidth: 1180px;
$gutter: 30px;
$gridGutter: 30px; // can be a %, but nested grids will have smaller margins because of it
$radius: 3px;

// Z-index
$zindexNavDropdowns: 5;
$zindexDrawer: 10;

/*================ Typography ================*/

$headerFontStack: serif;
$headerFontWeight: 700;

$bodyFontStack: sans-serif;
$baseFontSize: 14px; // Henseforth known as 1em

@font-face {
	font-family: 'icons';
	src: url('{{ "icons.eot" | asset_url }}');
	src: url('{{ "icons.eot" | asset_url }}#iefix') format("embedded-opentype"),
			 url('{{ "icons.woff" | asset_url }}') format("woff"),
			 url('{{ "icons.ttf" | asset_url }}') format("truetype"),
			 url('{{ "icons.svg" | asset_url }}#timber-icons') format("svg");
	font-weight: normal;
	font-style: normal;
}
$socialIconFontStack: 'icons';


/*============================================================================
	#Sass Mixins
==============================================================================*/
.clearfix {
	&:after {
		content: '';
		display: table;
		clear: both; }
	*zoom: 1;
}

@mixin clearfix() {
	&:after {
		content: '';
		display: table;
		clear: both; }
	*zoom: 1;
}

/*============================================================================
	Prefixer mixin for generating vendor prefixes:
		- Based on https://github.com/thoughtbot/bourbon/blob/master/app/assets/stylesheets/addons/_prefixer.scss
		- Usage:

			// Input:
			.element {
				@include prefixer(transform, scale(1), ms webkit spec);
			}

			// Output:
			.element {
				-ms-transform: scale(1);
				-webkit-transform: scale(1);
				transform: scale(1);
			}
==============================================================================*/

@mixin prefixer($property, $value, $prefixes) {
	@each $prefix in $prefixes {
		@if $prefix == webkit {
			-webkit-#{$property}: $value;
		} @else if $prefix == moz {
			-moz-#{$property}: $value;
		} @else if $prefix == ms {
			-ms-#{$property}: $value;
		} @else if $prefix == o {
			-o-#{$property}: $value;
		} @else if $prefix == spec {
			#{$property}: $value;
		} @else  {
			@warn "Unrecognized prefix: #{$prefix}";
		}
	}
}

@mixin transform($transform) {
	@include prefixer(transform, $transform, ms webkit spec);
}

@mixin user-select($value: none) {
	@include prefixer(user-select, $value, webkit moz ms spec);
}

@mixin backface($visibility: hidden) {
	@include prefixer(backface-visibility, $visibility, webkit spec);
}

@function em($target, $context: $baseFontSize) {
	@if $target == 0 {
		@return 0;
	}
	@return $target / $context + 0em;
}

@function color-control($color) {
	@if (lightness( $color ) > 40) {
		@return #000;
	}
	@else {
		@return #fff;
	}
}

/*============================================================================
	Layer promotion mixin for creating smoother animations with higher FPS.
==============================================================================*/
@mixin promote-layer($properties: transform) {
	-webkit-transform: translateZ(0); // translateZ hack
	will-change: $properties; // spec
}

/*============================================================================
	Dependency-free breakpoint mixin
		- Based on http://blog.grayghostvisuals.com/sass/sass-media-query-mixin/
		- Usage docs: http://shopify.github.io/Timber/#sass-mixins
==============================================================================*/
$min: min-width;
$max: max-width;
@mixin at-query ($constraint_, $viewport1_, $viewport2_:null) {
 $constraint: $constraint_; $viewport1: $viewport1_; $viewport2: $viewport2_;
	@if type-of($constraint_) == number {
		$viewport1 : $constraint_; $viewport2 : $viewport1_; $constraint : null;
	}
	@if $constraint == $min {
		@media screen and ($min: $viewport1) {
			@content;
		}
	} @else if $constraint == $max {
		@media screen and ($max: $viewport1) {
			@content;
		}
	} @else {
		@media screen and ($min: $viewport1) and ($max: $viewport2) {
			@content;
		}
	}
}

/*============================================================================
	#Normalize
==============================================================================*/
*, input, :before, :after {
	box-sizing: border-box;
}

html, body {
	padding: 0;
	margin: 0;
}

article, aside, details, figcaption, figure, footer, header, hgroup, main, nav, section, summary {
	display: block;
}

audio, canvas, progress, video {
	display: inline-block;
	vertical-align: baseline;
}

input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
	height: auto;
}

input[type="search"]::-webkit-search-cancel-button,
input[type="search"]::-webkit-search-decoration {
	-webkit-appearance: none;
}

/*============================================================================
	#Grid Setup
		- Based on csswizardry grid, but with floated columns, a fixed gutter size, and BEM classes
		- Breakpoints defined above, under #Breakpoint and Grid Variables
		- Note the inclusion of .grid-uniform to take care of clearfixes on evenly sized grid items
==============================================================================*/
$responsive:         true;
$mobile-first:       true;
$use-silent-classes: false;
$push:               true;
$pull:               false;

/* Force clearfix on grids */
.grid,
.grid-uniform {
	@include clearfix;
}

/* Manual grid__item clearfix */
.grid__item.clear {
	clear: both;
}

$class-type: unquote(".");

@if $use-silent-classes == true {
	$class-type: unquote("%");
}

@mixin grid-media-query($media-query) {
	$breakpoint-found: false;

	@each $breakpoint in $breakpoints {
		$name: nth($breakpoint, 1);
		$declaration: nth($breakpoint, 2);

		@if $media-query == $name and $declaration {
			$breakpoint-found: true;

			@media only screen and #{$declaration} {
				@content;
			}
		}
	}

	@if $breakpoint-found == false {
		@warn "Breakpoint '#{$media-query}' does not exist";
	}
}


/*============================================================================
	Drop relative positioning into silent classes which can't take advantage of
	the `[class*="push--"]` and `[class*="pull--"]` selectors.
==============================================================================*/
@mixin silent-relative() {
	@if $use-silent-classes == true {
		position:relative;
	}
}

/*============================================================================
	Grid Setup
		1. Allow the grid system to be used on lists.
		2. Remove any margins and paddings that might affect the grid system.
		3. Apply a negative `margin-left` to negate the columns' gutters.
==============================================================================*/
#{$class-type}grid,
#{$class-type}grid-uniform {
	list-style: none;
	margin: 0;
	padding: 0;
  
/*	margin-left: -$gridGutter; */
}

#{$class-type}grid__item {
	box-sizing: border-box;
	float: left;
	min-height: 1px;
	padding-left: $gridGutter;
	vertical-align: top;
	@if $mobile-first == true {
		width: 100%;
	}
}

/*============================================================================
	Reversed grids allow you to structure your source in the opposite
	order to how your rendered layout will appear.
==============================================================================*/
#{$class-type}grid--rev {
	@extend #{$class-type}grid;
	direction: rtl;
	text-align: left;

	> #{$class-type}grid__item {
		direction: ltr;
		text-align: left;
		float: right;
	}
}

/* Gutterless grids have all the properties of regular grids, minus any spacing. */
#{$class-type}grid--full {
	@extend #{$class-type}grid;
	margin-left: 0;

	> #{$class-type}grid__item {
		padding-left: 0;
	}
}

/*============================================================================
	WIDTHS
		- Create width classes, prefixed by the specified namespace.
==============================================================================*/
@mixin device-type($namespace:"") {
	/** Whole */
	#{$class-type}#{$namespace}one-whole       { width: 100%; }

	/* Halves */
	#{$class-type}#{$namespace}one-half        { width: 50%; }

	/* Thirds */
	#{$class-type}#{$namespace}one-third       { width: 33.333%; }
	#{$class-type}#{$namespace}two-thirds      { width: 66.666%; }

	/* Quarters */
	#{$class-type}#{$namespace}one-quarter     { width: 25%; }
	#{$class-type}#{$namespace}two-quarters    { width: 50%; }
	#{$class-type}#{$namespace}three-quarters  { width: 75%; }

	/* Fifths */
	#{$class-type}#{$namespace}one-fifth       { width: 20%; }
	#{$class-type}#{$namespace}two-fifths      { width: 40%; }
	#{$class-type}#{$namespace}three-fifths    { width: 60%; }
	#{$class-type}#{$namespace}four-fifths     { width: 80%; }

	/* Sixths */
	#{$class-type}#{$namespace}one-sixth       { width: 16.666%; }
	#{$class-type}#{$namespace}two-sixths      { width: 33.333%; }
	#{$class-type}#{$namespace}three-sixths    { width: 50%; }
	#{$class-type}#{$namespace}four-sixths     { width: 66.666%; }
	#{$class-type}#{$namespace}five-sixths     { width: 83.333%; }

	/* Eighths */
	#{$class-type}#{$namespace}one-eighth      { width: 12.5%; }
	#{$class-type}#{$namespace}two-eighths     { width: 25%; }
	#{$class-type}#{$namespace}three-eighths   { width: 37.5%; }
	#{$class-type}#{$namespace}four-eighths    { width: 50%; }
	#{$class-type}#{$namespace}five-eighths    { width: 62.5%; }
	#{$class-type}#{$namespace}six-eighths     { width: 75%; }
	#{$class-type}#{$namespace}seven-eighths   { width: 87.5%; }

	/* Tenths */
	#{$class-type}#{$namespace}one-tenth       { width: 10%; }
	#{$class-type}#{$namespace}two-tenths      { width: 20%; }
	#{$class-type}#{$namespace}three-tenths    { width: 30%; }
	#{$class-type}#{$namespace}four-tenths     { width: 40%; }
	#{$class-type}#{$namespace}five-tenths     { width: 50%; }
	#{$class-type}#{$namespace}six-tenths      { width: 60%; }
	#{$class-type}#{$namespace}seven-tenths    { width: 70%; }
	#{$class-type}#{$namespace}eight-tenths    { width: 80%; }
	#{$class-type}#{$namespace}nine-tenths     { width: 90%; }

	/* Twelfths */
	#{$class-type}#{$namespace}one-twelfth     { width: 8.333%; }
	#{$class-type}#{$namespace}two-twelfths    { width: 16.666%; }
	#{$class-type}#{$namespace}three-twelfths  { width: 25%; }
	#{$class-type}#{$namespace}four-twelfths   { width: 33.333%; }
	#{$class-type}#{$namespace}five-twelfths   { width: 41.666% }
	#{$class-type}#{$namespace}six-twelfths    { width: 50%; }
	#{$class-type}#{$namespace}seven-twelfths  { width: 58.333%; }
	#{$class-type}#{$namespace}eight-twelfths  { width: 66.666%; }
	#{$class-type}#{$namespace}nine-twelfths   { width: 75%; }
	#{$class-type}#{$namespace}ten-twelfths    { width: 83.333%; }
	#{$class-type}#{$namespace}eleven-twelfths { width: 91.666%; }
}

/*================ Clearfix helper on uniform grids ================*/
@mixin clearfix-helper($namespace:"") {
	.grid-uniform {
		#{$class-type}#{$namespace}one-half:nth-child(2n+1),
		#{$class-type}#{$namespace}one-third:nth-child(3n+1),
		#{$class-type}#{$namespace}one-quarter:nth-child(4n+1),
		#{$class-type}#{$namespace}one-fifth:nth-child(5n+1),
		#{$class-type}#{$namespace}one-sixth:nth-child(6n+1),
		#{$class-type}#{$namespace}two-sixths:nth-child(3n+1),
		#{$class-type}#{$namespace}three-sixths:nth-child(2n+1),
		#{$class-type}#{$namespace}two-eighths:nth-child(4n+1),
		#{$class-type}#{$namespace}four-eighths:nth-child(2n+1),
		#{$class-type}#{$namespace}five-tenths:nth-child(2n+1),
		#{$class-type}#{$namespace}one-twelfth:nth-child(12n+1),
		#{$class-type}#{$namespace}two-twelfths:nth-child(6n+1),
		#{$class-type}#{$namespace}three-twelfths:nth-child(4n+1),
		#{$class-type}#{$namespace}four-twelfths:nth-child(3n+1),
		#{$class-type}#{$namespace}six-twelfths:nth-child(2n+1)    { clear: both; }
	}
}

/*================ Helper show/hide classes around our breakpoints ================*/
@mixin device-helper($namespace:"") {
	#{$class-type}#{$namespace}show        { display: block!important; }
	#{$class-type}#{$namespace}hide        { display: none!important; }

	#{$class-type}#{$namespace}text-left   { text-align: left; }
	#{$class-type}#{$namespace}text-right  { text-align: right; }
	#{$class-type}#{$namespace}text-center { text-align: center; }

	#{$class-type}#{$namespace}left        { float: left!important; }
	#{$class-type}#{$namespace}right       { float: right!important; }
}

/*================ Our regular, non-responsive width and helper classes ================*/
@include device-type();
@include device-helper();

/*================ Our responsive classes, if we have enabled them ================*/
@if $responsive == true {
	@each $name in $breakpoint-has-widths {
		@include grid-media-query($name) {
			@include device-type('#{$name}--');
			@include device-helper('#{$name}--');
			@include clearfix-helper('#{$name}--');
		}
	}
}

/*============================================================================
	PUSH
		- Push classes, to move grid items over to the right by certain amounts
==============================================================================*/
@mixin push-setup($namespace: "") {
	/* Whole */
	#{$class-type}push--#{$namespace}one-whole       { left: 100%; @include silent-relative(); }

	/* Halves */
	#{$class-type}push--#{$namespace}one-half        { left: 50%; @include silent-relative(); }

	/* Thirds */
	#{$class-type}push--#{$namespace}one-third       { left: 33.333%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-thirds      { left: 66.666%; @include silent-relative(); }

	/* Quarters */
	#{$class-type}push--#{$namespace}one-quarter     { left: 25%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-quarters    { left: 50%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}three-quarters  { left: 75%; @include silent-relative(); }

	/* Fifths */
	#{$class-type}push--#{$namespace}one-fifth       { left: 20%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-fifths      { left: 40%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}three-fifths    { left: 60%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}four-fifths     { left: 80%; @include silent-relative(); }

	/* Sixths */
	#{$class-type}push--#{$namespace}one-sixth       { left: 16.666%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-sixths      { left: 33.333%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}three-sixths    { left: 50%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}four-sixths     { left: 66.666%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}five-sixths     { left: 83.333%; @include silent-relative(); }

	/* Eighths */
	#{$class-type}push--#{$namespace}one-eighth      { left: 12.5%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-eighths     { left: 25%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}three-eighths   { left: 37.5%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}four-eighths    { left: 50%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}five-eighths    { left: 62.5%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}six-eighths     { left: 75%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}seven-eighths   { left: 87.5%; @include silent-relative(); }

	/* Tenths */
	#{$class-type}push--#{$namespace}one-tenth       { left: 10%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-tenths      { left: 20%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}three-tenths    { left: 30%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}four-tenths     { left: 40%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}five-tenths     { left: 50%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}six-tenths      { left: 60%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}seven-tenths    { left: 70%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}eight-tenths    { left: 80%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}nine-tenths     { left: 90%; @include silent-relative(); }

	/* Twelfths */
	#{$class-type}push--#{$namespace}one-twelfth     { left: 8.333%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}two-twelfths    { left: 16.666%; @include silent-relative();  }
	#{$class-type}push--#{$namespace}three-twelfths  { left: 25%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}four-twelfths   { left: 33.333%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}five-twelfths   { left: 41.666%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}six-twelfths    { left: 50%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}seven-twelfths  { left: 58.333%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}eight-twelfths  { left: 66.666%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}nine-twelfths   { left: 75%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}ten-twelfths    { left: 83.333%; @include silent-relative(); }
	#{$class-type}push--#{$namespace}eleven-twelfths { left: 91.666%; @include silent-relative(); }
}

@if $push == true {
	[class*="push--"]{ position:relative; }

	@include push-setup();

	@if $responsive == true {
		@each $name in $breakpoint-has-push {
			@include grid-media-query($name) {
				@include push-setup('#{$name}--');
			}
		}
	}
}

/*============================================================================
	PULL
		- Pull classes, to move grid items back to the left by certain amounts
==============================================================================*/
@mixin pull-setup($namespace: "") {
	/* Whole */
	#{$class-type}pull--#{$namespace}one-whole       { right: 100%; @include silent-relative(); }

	/* Halves */
	#{$class-type}pull--#{$namespace}one-half        { right: 50%; @include silent-relative(); }

	/* Thirds */
	#{$class-type}pull--#{$namespace}one-third       { right: 33.333%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-thirds      { right: 66.666%; @include silent-relative(); }

	/* Quarters */
	#{$class-type}pull--#{$namespace}one-quarter     { right: 25%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-quarters    { right: 50%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}three-quarters  { right: 75%; @include silent-relative(); }

	/* Fifths */
	#{$class-type}pull--#{$namespace}one-fifth       { right: 20%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-fifths      { right: 40%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}three-fifths    { right: 60%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}four-fifths     { right: 80%; @include silent-relative(); }

	/* Sixths */
	#{$class-type}pull--#{$namespace}one-sixth       { right: 16.666%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-sixths      { right: 33.333%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}three-sixths    { right: 50%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}four-sixths     { right: 66.666%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}five-sixths     { right: 83.333%; @include silent-relative(); }

	/* Eighths */
	#{$class-type}pull--#{$namespace}one-eighth      { right: 12.5%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-eighths     { right: 25%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}three-eighths   { right: 37.5%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}four-eighths    { right: 50%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}five-eighths    { right: 62.5%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}six-eighths     { right: 75%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}seven-eighths   { right: 87.5%; @include silent-relative(); }

	/* Tenths */
	#{$class-type}pull--#{$namespace}one-tenth       { right: 10%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-tenths      { right: 20%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}three-tenths    { right: 30%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}four-tenths     { right: 40%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}five-tenths     { right: 50%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}six-tenths      { right: 60%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}seven-tenths    { right: 70%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}eight-tenths    { right: 80%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}nine-tenths     { right: 90%; @include silent-relative(); }

	/* Twelfths */
	#{$class-type}pull--#{$namespace}one-twelfth     { right: 8.333%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}two-twelfths    { right: 16.666%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}three-twelfths  { right: 25%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}four-twelfths   { right: 33.333%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}five-twelfths   { right: 41.666%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}six-twelfths    { right: 50%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}seven-twelfths  { right: 58.333%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}eight-twelfths  { right: 66.666%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}nine-twelfths   { right: 75%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}ten-twelfths    { right: 83.333%; @include silent-relative(); }
	#{$class-type}pull--#{$namespace}eleven-twelfths { right: 91.666%; @include silent-relative(); }
}

@if $pull == true {
	[class*="pull--"]{ position:relative; }

	@include pull-setup();

	@if $responsive == true {
		@each $name in $breakpoint-has-pull {
			@include grid-media-query($name) {
				@include pull-setup('#{$name}--');
			}
		}
	}
}

/*============================================================================
	#Basic Styles
==============================================================================*/
html {
	background-color: $colorFooterBg;
}

body {
	background-color: $colorBody;
}

[tabindex='-1']:focus {
	outline: none;
}

.wrapper {
	@include clearfix();
	max-width: $siteWidth;
	margin: 0 auto;
	padding: 0 ($gutter / 2);

	@include at-query ($min, $small) {
		padding: 0 $gutter;
	}
}

.main-content {
	display: block;
	margin-top: $gutter;
	.template-index &{margin-top: 0;}
}

/*============================================================================
	#Helper Classes
==============================================================================*/
.is-transitioning {
	display: block !important;
	visibility: visible !important;
}

.display-table {
	display: table;
	table-layout: fixed;
	width: 100%;
}

.display-table-cell {
	display: table-cell;
	vertical-align: middle;
	float: none;
}

@include at-query ($min, $large) {
	.large--display-table {
		display: table;
		table-layout: fixed;
		width: 100%;
	}

	.large--display-table-cell {
		display: table-cell;
		vertical-align: middle;
		float: none;
	}
}

.visually-hidden {
	position: absolute;
	overflow: hidden;
	clip: rect(0 0 0 0);
	height: 1px; width: 1px;
	margin: -1px; padding: 0; border: 0;
}

/*============================================================================
	#Typography
==============================================================================*/
body,
input,
textarea,
button,
select {
	font-size: $baseFontSize;
	line-height: 1.6;
	font-family: $bodyFontStack;
	color: $colorTextBody;
/*	font-weight: 300; */
	-webkit-font-smoothing: antialiased;
	-webkit-text-size-adjust: 100%;
}

h1, h2, h3, h4, h5, h6 {
	display: block;
	font-family: $headerFontStack;
	font-weight: $headerFontWeight;
	margin: 0 0 0.5em;
	line-height: 1.4;
	text-transform: capitalize;
	a {
		text-decoration: none;
		font-weight: inherit;
	}
}

/*================ Use em() Sass function to declare font-size ================*/
h1 {
	font-size: em(24px);
/*	text-transform: uppercase; */
}

h2 {
	font-size: em(22px);
}

h3 {
	font-size: em(20px);
}

h4 {
	font-size: em(18px);
}

h5 {
	font-size: em(16px);
}

h6 {
	font-size: em(14px);
}


.h1 { @extend h1; }
.h2 { @extend h2; }
.h3 { @extend h3; }
.h4 { @extend h4; }
.h5 { @extend h5; }
.h6 { @extend h6; }

p {
	margin: 0 0 ($gutter / 2) 0;

	img {
		margin: 0;
	}
}

em {
	font-style: italic;
}

b, strong {
	font-weight: bold;
}

small {
	font-size: 0.9em;
}

sup, sub {
	position: relative;
	font-size: 60%;
	vertical-align: baseline;
}
sup {
	top: -0.5em;
}

sub {
	bottom: -0.5em;
}

/*================ Blockquotes ================*/
blockquote {
	font-size: 1.125em;
	line-height: 1.45;
	font-style: italic;
	margin: 0 0 $gutter;
	padding: ($gutter / 2) $gutter;
	border-left: 1px solid $colorBorder;

	p {
		margin-bottom: 0;

		& + cite {
			margin-top: $gutter / 2;
		}
	}

	cite {
		display: block;
		font-size: 0.75em;

		&:before {
			content: '\2014 \0020';
		}
	}
}

/*================ Code ================*/
code, pre {
	background-color: #faf7f5;
	font-family: Consolas,monospace;
	font-size: 1em;
	border: 0 none;
	padding: 0 2px;
	color: #51ab62;
}

pre {
	overflow: auto;
	padding: $gutter / 2;
	margin: 0 0 $gutter;
}

/*================ Horizontal Rules ================*/
hr {
	clear: both;
	border-top: solid $colorBorder;
	border-width: 1px 0 0;
	margin: $gutter 0;
	height: 0;

	&.hr--small {
		margin: ($gutter / 2) 0;
	}

	&.hr--clear {
		border-top-color: transparent;
	}
}

/*================ Section Headers ================*/
h1, h2, h3, h4, h5, h6,
.section-header {
	margin-bottom: $gutter / 1.5;
	color: #fff;
}

@include at-query ($min, $large) {
	.section-header {
		display: table;
		width: 100%;
	}

	.section-header__title {
		margin-bottom: $gutter / 2.5;
	}

	.section-header__left {
		display: table-cell;
		vertical-align: middle;
		margin-bottom: 0;

		h1, h2, h3, h4,
		.h1, .h2, .h3, .h4 {
		}
	}

	.section-header__right {
		display: table-cell;
		vertical-align: middle;
		text-align: right;
		width: 335px;

		@include at-query ($max, $medium) {
			margin-bottom: $gutter;
		}
	}
}

.section-header__right {
	.form-horizontal,
	.collection-view {
		display: inline-block;
		vertical-align: middle;
	}

	@include at-query ($min, $postSmall) {
		label + select{
			margin-left: $gutter / 2;
		}
	}
}

.collection-view {
	display: inline-block;
	overflow: hidden;
	button{
		border-right: 1px solid $colorBorder;
		height: 42px;
		width: 42px;
	}

	/*================ Only show on larger screens ================*/
	@include at-query ($min, $large) {
		display: inline-block;
	}
}
/*
.change-view {
	display: block;
	background: none;
	border: 0 none;
	color: $colorBorder;
	line-height: 1;

	&:hover,
	&:focus {
		color: $colorPrimary;
	}
}

.change-view--active {
	cursor: default;
	color: $colorPrimary;
}
*/
/*============================================================================
	#Rich Text Editor
==============================================================================*/
.rte {
	margin-bottom: $gutter / 2;
	margin-top: $gutter / 2;

	a {
		text-decoration: underline;
	}

	// Add some top margin to headers from the rich text editor
	h1, h2, h3, h4, h5, h6 {
		margin-top: 2em;

		&:first-child {
			margin-top: 0;
		}

		a {
			text-decoration: none;
		}
	}

	> div {
		margin-bottom: $gutter / 2;
	}

	li {
		margin-bottom: 0.4em;
	}
}

.rte--header {
	margin-bottom: 0;
}

/*============================================================================
	#Links and Buttons
==============================================================================*/
a,
.text-link {
	color: $colorLink;
	text-decoration: none;
	background: transparent;
}

a:hover,
a:focus {
	color: $colorLinkHover;
	outline: none;
}

button {
	overflow: visible;
}

button[disabled],
html input[disabled] {
	cursor: default;
}
/*
.btn,
.rte .btn {
	display: inline-block;
	padding: 8px 10px;
	width: auto;
	margin: 0;
	line-height: 1.42;
	text-decoration: none;
	text-align: center;
	text-transform: uppercase;
	vertical-align: middle;
	white-space: nowrap;
	cursor: pointer;
	border: none;
	@include user-select(none);
	-webkit-appearance: none;
	-moz-appearance: none;
	border-radius: $radius;
	font-family: {{settings.button_font}}, Arial;
	font-size: 12px;
	letter-spacing: 2px;
*/
	/*================ Set primary button colors - can override later ================*/
/*	
	background-color: $colorBtnPrimary;
	color: $colorBtnPrimaryText;

	&:hover {
		background-color: $colorBtnPrimaryHover;
		color: $colorBtnPrimaryText;
	}

	&:active,
	&:focus {
	 background-color: $colorBtnPrimaryActive;
	 color: $colorBtnPrimaryText;
	}

	&[disabled],
	&.disabled {
		cursor: default;
		color: $disabledBorder;
		background-color: $disabledGrey;
	}
}

.btn--secondary,
.rte .btn--secondary {
	@extend .btn;
	background-color: $colorBtnSecondary;

	&:hover {
		background-color: $colorBtnSecondaryHover;
		color: $colorBtnSecondaryText;
	}

	&:active,
	&:focus {
	 background-color: $colorBtnSecondaryActive;
	 color: $colorBtnSecondaryText;
	}
}

.btn--small {
	padding: 4px 5px;
	font-size: em(12px);
}

.btn--large {
	padding: 12px 15px;
	font-size: em(16px);
}

.btn--full {
	width: 100%;
}
*/
/*================ Force an input/button to look like a text link ================*/
.text-link {
	display: inline;
	border: 0 none;
	background: none;
	padding: 0;
	margin: 0;
}

/*============================================================================
	#Lists
==============================================================================*/
/*
ul, ol {
	margin: 0 0 ($gutter / 2) 20px;
	padding: 0;
}

ol { list-style: decimal; }

ul ul, ul ol,
ol ol, ol ul { margin: 4px 0 5px 20px; }
li { margin-bottom: 0.25em; } 
*/

ul.square { list-style: square outside; }
ul.disc { list-style: disc outside; }
ol.alpha { list-style: lower-alpha outside; }

.no-bullets {
	list-style: none outside;
	margin-left: 0;
}

.inline-list {
	margin-left: 0;

	li {
		display: inline-block;
		margin-bottom: 0;
	}
}

/*============================================================================
	#Tables
==============================================================================*/
table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

table.full {
	width: 100%;
	margin-bottom: 1em;
}

.table-wrap {
	max-width: 100%;
	-webkit-overflow-scrolling: touch;
}

th {
	font-weight: bold;
}

th, td {
	text-align: left;
	padding: $gutter / 2;
/*	border: 1px solid $colorBorder; */
}

/*============================================================================
	Responsive tables, defined with .table--responsive on table element.
	Only defined for IE9+
==============================================================================*/
.table--responsive {
	@include at-query($max, $small) {
		thead {
			display: none;
		}

		tr {
			display: block;
		}

		// IE9 table layout fixes
		tr,
		td {
			float: left;
			clear: both;
			width: 100%;
		}

		th,
		td {
			display: block;
			text-align: left;
			padding: 15px;
		}

		td:before {
			content: attr(data-label);
			float: left;
			text-align: center;
			font-size: 12px;
			padding-right: 10px;
		}

		&.cart-table {
			img {
				margin: 0 auto;
			}

			.js-qty {
				float: right;
			}
		}
	}
}

@include at-query($max, $small) {
	.table--small-hide {
		display: none !important;
	}

	.table__section + .table__section {
		position: relative;
		margin-top: 10px;
		padding-top: 15px;

		&:after {
			content: '';
			display: block;
			position: absolute;
			top: 0;
			left: 15px;
			right: 15px;
			border-bottom: 1px solid $colorBorder;
		}
	}
}


/*============================================================================
	#OOCSS Media Object
		- http://www.stubbornella.org/content/2010/06/25/the-media-object-saves-hundreds-of-lines-of-code/
==============================================================================*/
.media,
.media-flex {
	overflow: hidden;
	_overflow: visible;
	zoom: 1;
}

.media-img {
	float: left;
	margin-right: $gutter;
}

.media-img-right {
	float: right;
	margin-left: $gutter;
}

.media-img img,
.media-img-right img {
	display: block;
}


/*============================================================================
	#Images and Iframes
==============================================================================*/
img {
	border: 0 none;
}

svg:not(:root) {
	overflow: hidden;
}

img,
iframe {
	max-width: 100%;
}

.video-wrapper { 
/*	position: relative; */
	overflow: hidden;
	max-width: 100%;
/*	padding-bottom: 56.25%; */
	height: 0;
	height: auto;

	iframe {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}
}


/*============================================================================
	#Forms
==============================================================================*/
form {
	margin-bottom: 0;
}

.form-vertical {
	margin-bottom: $gutter / 2;
}

/*================ Prevent zoom on touch devices in active inputs ================*/
@include at-query($max, $medium) {
	input,
	textarea {
		font-size: 16px;
	}
}

input,
textarea,
button,
select {
	padding: 0;
	margin: 0;
	@include user-select(text);
}

button {
	background: none;
	border: none;
	cursor: pointer;
}

button,
input,
textarea {
	-webkit-appearance: none;
	-moz-appearance: none;
}

button {
	background: none;
	border: none;
	display: inline-block;
	cursor: pointer;
	outline: none;
}

input[type="image"] {
	padding-left: 0;
	padding-right: 0;
}

fieldset {
	border: 1px solid $colorBorder;
	padding: $gutter / 2;
}

legend {
	border: 0;
	padding: 0;
}

button,
input[type="submit"] {
	cursor: pointer;
}

input,
textarea,
select {
	border: 1px solid $colorBorder;
	max-width: 100%;
	padding: 8px 10px;
	border-radius: $radius;

	&:focus {
		border: 1px solid darken($colorBorder, 10%);
	}

	&[disabled],
	&.disabled {
		cursor: default;
		background-color: $disabledGrey;
		border-color: $disabledBorder;
	}

	&.input-full {
		width: 100%;
	}
}

textarea {
	min-height: 100px;
}

/*================ Input element overrides ================*/
input[type="checkbox"],
input[type="radio"] {
	display: inline;
	margin: 0 8px 0 0;
	padding: 0;
	width: auto;
}

input[type="checkbox"] {
	-webkit-appearance: checkbox;
	-moz-appearance: checkbox;
}

input[type="radio"] {
	-webkit-appearance: radio;
	-moz-appearance: radio;
}

input[type="image"] {
	padding-left: 0;
	padding-right: 0;
}

/*
select {
	-webkit-appearance: none;
		 -moz-appearance: none;
					appearance: none;
	background-position: right center;
	background: {
		image: url('{{ "ico-select.svg" | asset_url }}');
		repeat: no-repeat;
		position: right 10px center;
		color: transparent;
	}
	padding-right: 28px;
	text-indent: 0.01px;
	text-overflow: '';
	cursor: pointer;

	.ie9 &,
	.lt-ie9 & {
		padding-right: 10px;
		background-image: none;
	}
}
*/

optgroup {
	font-weight: bold;
}

// Force option color (affects IE only)
option {
	color: #000;
	background-color: #fff;
}

select::-ms-expand {
	display: none;
}

/*================ Form labels ================*/
.hidden-label {
	position: absolute;
	height: 0;
	width: 0;
	margin-bottom: 0;
	overflow: hidden;
	clip: rect(1px, 1px, 1px, 1px);

	// No placeholders, so force show labels
	.ie9 &,
	.lt-ie9 & {
		position: static;
		height: auto;
		width: auto;
		margin-bottom: 2px;
		overflow: visible;
		clip: initial;
	}
}

label[for] {
	cursor: pointer;
}

/*================ Horizontal Form ================*/
.form-vertical {
	input,
	select,
	textarea {
		margin-bottom: 10px;
	}

	input[type="radio"],
	input[type="checkbox"] {
		display: inline-block;
	}
}

/*================ Error styles ================*/
input,
select,
textarea {
	&.error {
		border-color: $errorRed;
		background-color: $errorRedBg;
		color: $errorRed;
	}
}

label.error {
	color: $errorRed;
}


/*================ Input Group ================*/
.input-group {
	position: relative;
	display: table;
	border-collapse: separate;

	.input-group-field:first-child,
	.input-group-btn:first-child,
	.input-group-btn:first-child > .btn,
	input[type="hidden"]:first-child + .input-group-field,
	input[type="hidden"]:first-child + .input-group-btn > .btn {
		border-radius: $radius 0 0 $radius;
	}

	.input-group-field:last-child,
	.input-group-btn:last-child > .btn {
	 border-radius: 0 $radius $radius 0;
	}

	input {
		// Nasty Firefox hack for inputs http://davidwalsh.name/firefox-buttons
		&::-moz-focus-inner {
			border: 0;
			padding: 0;
			margin-top: -1px;
			margin-bottom: -1px;
		}
	}
}

.input-group-field,
.input-group-btn {
	display: table-cell;
	vertical-align: middle;
	margin: 0;
}

.input-group .btn,
.input-group .input-group-field {
	height: 37px;
}

.input-group .input-group-field {
	width: 100%;
}

.input-group-btn {
	position: relative;
	white-space: nowrap;
	width: 1%;
	padding: 0;
}

/*============================================================================
	#Icons
==============================================================================*/
.icon-fallback-text .icon {
	display: none;

	.supports-fontface & {
		display: inline-block;
		color: #ccc;
      	font-size: 8px;
	}
	.supports-fontface &.icon-search{color: #fff;}
	.site-header__topbar &.icon-search{color: #000;}
}

/*============================================================================
	A generic way to visually hide content while
	remaining accessible to screen readers (h5bp.com)
==============================================================================*/
.supports-fontface .icon-fallback-text .fallback-text {
	@extend .visually-hidden;
}
/* 
.icon:before {
	display: none;
}
 */
.supports-fontface .icon:before {
	display: inline;
/*	font-family: $socialIconFontStack;  */
	text-decoration: none;
	speak: none; // future fallback, limited in effect currently
	font-style: normal;
	font-weight: normal;
	font-variant: normal;
	text-transform: none;
	line-height: 1;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

/*================ Icon mapping ================*/
.icon-amazon_payments:before { content: "\e800"; }
.icon-american_express:before { content: "\41"; }
.icon-arrow-down:before { content: "\e607"; }
.icon-bitcoin:before { content: "\42"; }
/*
.icon-cart:before { content: "\e600"; }
.icon-search:before { content: "\73"; }
*/
.icon-cirrus:before { content: "\43"; }
.icon-dankort:before { content: "\64"; }
.icon-diners_club:before { content: "\63"; }
.icon-discover:before { content: "\44"; }
.icon-facebook:before { content: "\66"; }
.icon-fancy:before { content: "\46"; }
.icon-google:before { content: "\67"; }
.icon-google_wallet:before { content: "\47"; }
.icon-grid-view:before { content: "\e603"; }
.icon-hamburger:before { content: "\e601"; }
.icon-instagram:before { content: "\69"; }
.icon-interac:before { content: "\49"; }
.icon-jcb:before { content: "\4a"; }
.icon-list-view:before { content: "\e604"; }
.icon-maestro:before { content: "\6d"; }
.icon-master:before { content: "\4d"; }
.icon-minus:before { content: "\e602"; }
.icon-paypal:before { content: "\50"; }
.icon-pinterest:before { content: "\70"; }
.icon-plus:before { content: "\e605"; }
.icon-rss:before { content: "\72"; }
.icon-stripe:before { content: "\53"; }
.icon-tumblr:before { content: "\74"; }
.icon-twitter:before { content: "\54"; }
.icon-vimeo:before { content: "\76"; }
.icon-visa:before { content: "\56"; }
.icon-x:before { content: "\e606"; }
.icon-youtube:before { content: "\79"; }

.payment-icons {
	@include user-select(none);
	cursor: default;

	li {
		margin: 0 ($gutter / 4) ($gutter / 4);
		color: #fff;
		cursor: default;
	}

	.icon {
		font-size: 30px;
		line-height: 30px;
	}

	.fallback-text {
		text-transform: capitalize;
	}
}

.social-icons li {
	margin: 0 ($gutter / 2) ($gutter / 2);
	vertical-align: middle;

	@include at-query ($min, $postSmall) {
		margin-left: 0;
	}

	.icon {
		font-size: 30px;
		line-height: 26px;
	}

	a {
		color: #fff;

		&:hover {
			color: #fff;
		}
	}
}

/*============================================================================
	#Pagination
==============================================================================*/
.pagination {
	margin-bottom: 1em;
    display: block;
	> span {
		display: inline-block;
		line-height: 1;
	}

	a {
		display: block;
	}

	a,
	.page.current {
	}
}

/*============================================================================
	#Site Header
==============================================================================*/
.site-header {

	.grid--table {
		display: table;
		table-layout: fixed;
		width: 100%;

		> .grid__item {
			float: none;
			display: table-cell;
			vertical-align: middle;
		}
	}
}
.site-header__topbar {
	height: 50px;
	padding: 6px;
	border-bottom: 1px solid $colorBorder;

	.search-bar {
		input[type="search"] {
			height: 50px;
			margin-top: -7px;
			border-top: none;
			border-bottom: none;
			border-color: $colorBorder;
			background:$colorBody;
		}
		button{background: none;margin-top: -8px;}
	}
}
.site-header__logo {

	@include at-query ($min, $large) {
		text-align: left;
	}

	a,
	a:hover,
	a:focus {
		text-decoration: none;
	}

	a{
		display: block;
	}

	img {
		margin: 0 auto;
	}
}

.site-header__logo-link {
	max-width: $logoMaxWidth;
	margin: 0 auto;
}

.site-header__cart-toggle {
	display: inline-block;
	line-height: 36px;
}

.site-header__search {
	display: inline-block;
	max-width: 250px;
	width: 100%;
	.input-group-btn {
		position: absolute;
		right: 5px;
		top: 0;
		width: 40px;
		height: 37px;
		padding: 8px;
	}
	.icon-search{font-size: 12px;}
}

.search-bar {
	width: 100%;

	@include at-query ($max, $medium) {
		margin-left: auto;
		margin-right: auto;
	}
}

.site-header__account{
	position: relative;
	    margin-top: 6px;
	a {
		position: relative;
		text-transform: capitalize;
	}
	i{width: 18px; color: #000;}
	& > span {
		padding: 6px 15px 20px;
		i{color: #000;}
	}
	ul {
		list-style: none;
		margin: 0;
		visibility: hidden;
		background: #fff;
		width: 200px;
		position: absolute;
		left: 0;
		box-shadow: 0px 3px 9px 0px #ccc;

		z-index: 2;
		    top: 37px;
		li {
			margin: 0;
			padding: 10px 10px 10px 16px;
			border-bottom: 1px solid $colorBorder;
			    font-style: normal;
		}
	}
	&:hover {
		& > span {
			box-shadow: 0 0 9px #ccc;
		}
		ul {
			visibility: visible;
			transition: all ease 0.3s;
		}
	}
}

/* #currencies {
    display: inline-block;
    zoom: 1;
    cursor: pointer;
    margin-left: 7px;
    span {
		display: inline-block;
		zoom: 1;
		padding: 0px 10px;
		margin-top: 7px;
		border-left: 1px solid $colorBorder;
		float: left;
	}
	.selected {
		font-weight: normal;
		background: none #eeeeee;
	}
}
 */
/*============================================================================
	#Site Nav and Dropdowns
==============================================================================*/
.nav-bar {
	.medium-down--hide{text-align: center;background-color: $colorNav;position: relative;}
}
.site-nav {
	font-size: em(14px);
	cursor: default;
	margin: 0 0 0 (-$gutter / 2);
	display: block;
	text-align: left;
	li {
		margin: 0;
		display: block;
	}

	& > li {
		position: relative;
		display: inline-block;
      	margin-left: 20px;
	}
}

/*================ Home to hamburger and cart that toggle drawers ================*/
.site-nav--mobile {
	@extend .site-nav;

	.text-right & {
		margin: 0 (-$gutter / 2) 0 0;
	}
}

.site-nav__link {
	display: block;
	text-decoration: none;
	padding: 0 22px;
	white-space: nowrap;
	color: $colorNavText;
	text-transform: uppercase;
    letter-spacing: 0.04em;
	position: relative;
	.site-nav--has-dropdown &{padding-left: 10px; border: none; }
	    font-size: 16px;
	    border-bottom: 2px solid transparent;
  		font-weight: bold;

	&:hover,
	&:active,
	&:focus {
		color: $colorDefault;
	}

	.icon-arrow-down {
		position: relative;
		top: 0px;
		font-size: 10px;
		padding-left: $gutter / 4;
	}

	.site-nav--active > & {
		color: $colorDefault;
	}

	.site-nav--mobile & {
		display: inline-block;
	}
	.site-nav > li > &{ padding: 0px 20px;}
	.site-nav > li:first-child > &{border-left: none;}
}

/*================ Dropdowns ================*/
.site-nav__dropdown {
	display: none;
	position: absolute;
	left: 0;
	margin: 0;
	z-index: $zindexNavDropdowns;
	min-width: 200px;
	box-shadow: 0 1px 4px #ccc;
	background-color: $colorSubNav;
	-webkit-animation: 0.5s ease 0s normal forwards 1 running animationmenus;
	    -o-animation: 0.5s ease 0s normal forwards 1 running animationmenus;
	    animation: 0.5s ease 0s normal forwards 1 running animationmenus;
	    -webkit-transform-origin: 50% 50% 0;
	    -moz-transform-origin: 50% 50% 0;
	    -ms-transform-origin: 50% 50% 0;
	    transform-origin: 50% 50% 0;

	.supports-no-touch .site-nav--has-dropdown:hover &,
	.site-nav--has-dropdown.nav-hover &,
	.nav-focus + & {
		display: block;
	}

	li {
        > a {
          color: $colorSubNavText;
          display: block;
          text-transform: none;
          padding: 10px 10px 10px 20px!important;
          line-height: 16px;
          text-align: left;
          &:hover,
          &:active,
          &:focus {
              color: $colorDefault;
          }
      }
    }
}

.site-nav li.site-nav--has-dropdown > .dropdown:hover > .site-nav__dropdown,
.site-nav li.site-nav--has-dropdown > .dropdown.open > .site-nav__dropdown { display: block; }
.megamenu-dropdown{
	position: static!important;
	.site-nav__dropdown{
		width: 100%;
		padding: 30px;
		h3{
			font-size: 14px; color:$colorSubNavText;text-align:left;
		}
		ul{
			margin-left: 0;
			a{padding-left: 0!important;}
		}
	}
	.grid__item.large--one-fifth {
	    border-left: 1px solid lighten($colorSubNav,20%);
	    min-height: 250px;
	    &:first-child{border-left: none;}
	}
}

/*================ Search bar in header ================*/
.nav-search {
	position: relative;
	padding: 10px 0;

	@include at-query ($max, $medium) {
		padding: 0 0 ($gutter / 2);
		margin: 0 auto;
		text-align: center;
	}
}

/*============================================================================
	#Mobile Nav
	- List of items inside the mobile drawer
==============================================================================*/
.mobile-nav {
	// Negative of .drawer left/right padding for full-width link tap area
	margin: (-$gutter / 2) (-$gutter / 2) 0 (-$gutter / 2);

	li {
		margin-bottom: 0;
	}
	ul.super{list-style: none;}
	h3 {
	    padding-left: 15px;
	    font-size: 14px;
	}
}

.mobile-nav__search {
	padding: $gutter / 2;

	.search-bar {
		margin-bottom: 0;
	}
}

.mobile-nav__item {
	position: relative;
	display: block;

	// Background color on top level items so there is no
	// element overlap on subnav's CSS toggle animation
	.mobile-nav > & {
		background-color: $colorDrawers;
	}

	&:after {
		content: '';
		position: absolute;
		bottom: 0;
		left: $gutter / 2;
		right: $gutter / 2;
		border-bottom: 1px solid $colorDrawerBorder;
	}

	.mobile-nav > &:last-child:after {
		display: none;
	}
}

// Login/logout links can't have a class on them, so style <a> element
.mobile-nav__item a {
	display: block;
}

.mobile-nav__item a,
.mobile-nav__toggle button {
	color: $colorDrawerText;
	padding: $gutter / 2;
	text-decoration: none;

	&:hover,
	&:active,
	&:focus {
		color: darken($colorDrawerText, 15%);
	}

	&:active,
	&:focus {
		background-color: darken($colorDrawers, 5%);
	}
}

.mobile-nav__item--active {
	font-weight: bold;
}

.mobile-nav__has-sublist {
	display: table;
	width: 100%;

	.mobile-nav__link {
		display: table-cell;
		vertical-align: middle;
		width: 100%;
	}
}

.mobile-nav__toggle {
	display: table-cell;
	vertical-align: middle;
	width: 1%;
}

.mobile-nav__toggle-open {
	.mobile-nav--expanded & {
		display: none;
	}
}

.mobile-nav__toggle-close {
	display: none;

	.mobile-nav--expanded & {
		display: block;
	}
}

.mobile-nav__sublist {
	margin: 0;
	max-height: 0;
	visibility: hidden;
	overflow: hidden;
	transition: all 300ms cubic-bezier(0.57, 0.06, 0.05, 0.95);
	@include backface();

	.mobile-nav--expanded + & {
		visibility: visible;
		max-height: 700px;
		transition: all 700ms cubic-bezier(0.57, 0.06, 0.05, 0.95);
	}

	.mobile-nav__item:after {
		top: 0;
		bottom: auto;
	}

	.mobile-nav__link {
		padding-left: $gutter;
		font-weight: normal;
	}
}

/*============================================================================
	#Drawers
==============================================================================*/
.js-drawer-open {
	overflow: hidden;
	height: 100%;
	#PageContainer:before{
	    background: rgba(0, 0, 0, 0.5) none repeat scroll 0 0;
	    bottom: 0;
	    content: "" !important;
	    display: inline-block !important;
	    left: 0;
	    position: absolute;
	    right: 0;
	    top: 0;
	    z-index: 99999;

	}
}

.drawer {
	@include promote-layer();
	display: none;
	position: fixed;
	overflow-y: auto;
	overflow-x: hidden;
	-webkit-overflow-scrolling: touch;
	top: 0;
	bottom: 0;
	padding: 0 ($gutter / 2) ($gutter / 2);
	max-width: 95%;
	z-index: $zindexDrawer;
	color: $colorDrawerText;
	background-color: $colorDrawers;
	transition: $drawerTransition;

	a {
		color: $colorDrawerText;

		&:hover,
		&:focus {
			opacity: 0.7;
		}
	}

	input,
	textarea {
		border-color: $colorDrawerBorder;
	}
}

.drawer--left {
	width: $drawerNavWidth;
	left: -$drawerNavWidth;
	border-right: 1px solid $colorDrawerBorder;

	.js-drawer-open-left & {
		display: block;
		@include transform(translateX($drawerNavWidth));

		.lt-ie9 & {
			left: 0;
		}
	}
}

.drawer--right {
	width: $drawerCartWidth;
	right: -$drawerCartWidth;
	border-left: 1px solid $colorDrawerBorder;

	.js-drawer-open-right & {
		display: block;
		@include transform(translateX(-$drawerCartWidth));

		.lt-ie9 & {
			right: 0;
		}
	}
}

#PageContainer {
	overflow: hidden;
}
.drawer--is-loading{
	&:before{
		background: rgba(0, 0, 0, 0.5) none repeat scroll 0 0;
	    bottom: 0;
	    content: "" !important;
	    display: inline-block !important;
	    left: 0;
	    position: absolute;
	    right: 0;
	    top: 0;
	    z-index: 99999;
	}
}
.is-moved-by-drawer {
	//@include promote-layer();
	transition: $drawerTransition;

	.js-drawer-open-left & {
		@include transform(translateX($drawerNavWidth));
	}

	.js-drawer-open-right & {
		@include transform(translateX(-$drawerCartWidth));
	}
}

.drawer__header {
	display: table;
	height: 70px;
	width: 100%;
	margin-bottom: $gutter / 2;
	border-bottom: 1px solid $colorDrawerBorder;
}

.drawer__title,
.drawer__close {
	display: table-cell;
	vertical-align: middle;
}

.drawer__title {
	width: 100%;
}

.drawer__close {
	width: 1%;
	text-align: center;
	font-size: em(18px);
}

.drawer__close button {
	position: relative;
	right: -20px;
	height: 100%;
	padding: 0 20px;
	color: inherit;

	&:active,
	&:focus {
		background-color: darken($colorDrawers, 5%);
	}
}

/*============================================================================
	#Site Footer
==============================================================================*/
.site-footer {
  /*
	background-color: $colorFooterBg;
	color: $colorFooterText;
	    line-height: 24px;
	a{color: $colorFooterText;}
	@include at-query ($min, $large) {
		padding: ($gutter * 2) 0 0;
	}
  */
	h4{color: #fff; font-size: 14px;text-transform: uppercase;}
	.site-footer__top{
		padding: 20px 0;
		border-top: 2px solid #000;
		&>div{margin-top: 30px;}
	}
	.site-footer__newsletter{
		.newsletter-form{
			display: inline-block;
			border: 1px solid $colorBorder;
			text-align: left;
			vertical-align: middle;
			    box-sizing: content-box;
			    background: #fff;
			@include at-query($max, $small) {
				width: 200px;
				input{width: 200px;}
				label{display: none;}
			}
			input { border: none; width: 333px; background: $colorFooterBg;}
			label {
				font-size: 12px;
				text-transform: uppercase;
				margin: 6px 0px 6px 10px;
				line-height: 30px;
				padding-right: 10px;
				border-right: 1px solid $colorBorder;
				font-family: $headerFontStack;
				color: #fff;
				}		}
	#subscribe{height:44px;    padding-left: 20px;
    padding-right: 20px;}
	}
	.site-footer__social{
		li{margin: 0 8px;}
		a{
			color: #fff;
			&:hover{color: $colorDefault;}
		}
	}
	.site-footer__main{
		padding-top: 20px;
		padding-bottom: 20px;
		ul li {
			a {
				position: relative;
				padding: 2px 0;
				display: block;
				margin-right: 10px;
				transition: all ease 0.3s;
				&:before {
					position: absolute;
					content: "\f178";
					font-family: FontAwesome;
					right: 10px;
					top: 2px;
				}
				&:hover{
					background: #eee;
    				padding-left: 10px;
    				transition: all ease 0.3s;
				}
			}
		}
	}

	ul{
		list-style: none;
		margin: 0;
	}

	.site-footer__copyright{padding-bottom: 40px; border-bottom: 4px solid #000;}
}

/*============================================================================
	#Index page
==============================================================================*/
h2.title{text-align: center;position: relative; margin-bottom: 50px;
	font-size: 48px;
    text-transform: uppercase;
    letter-spacing: -2px;
	&:before {
		position: absolute;
		content: "";
		bottom: -35px;
		left: 50%;
		margin-left: -80px;
		width: 160px; height: 24px; background-position: 0 -35px;
	}
	&.widget__title{
		text-align: left;
		&:before{
		left: 0;
	    margin-left: 0;
	    background-position: -50px -35px;
	    width: 120px;
		}
	}
}
.tab-products .nav-tabs{
	@extend h2;
	@extend h2.title;
}

.slider-carousel {
	&.owl-theme .owl-controls .owl-buttons div.owl-prev {
		right: 52px;
	}
	&.owl-theme .owl-controls .owl-buttons div.owl-next {
		right: 52px;
		margin-right: -52px;
	}
	&.owl-theme .owl-controls .owl-buttons div {
		width: 50px;
		height: 50px;
		top: 48%;

		&:before {
			line-height: 50px;
		}
	}
	.text{
		position: absolute;
		text-align: left;
		top: 43%;
		width: 300px;
		font-size: 16px;
		left: 20%;color: #000;
		.btn{background: transparent; margin-top: 20px;}
	}

}
.products {
	&.owl-theme .owl-controls .owl-buttons div {
		top: -80px;
	}
}

.section-brand {
	.owl-buttons{display: none;}
	&:hover{
		.owl-buttons{display: block;}
	}
	& .owl-theme .owl-controls .owl-buttons div.owl-prev {
		left: -30px;
	}
	& .owl-theme .owl-controls .owl-buttons div.owl-next {
		right: -30px;
	}
	img{
		border: 1px solid transparent;
		&:hover{border: 1px solid $colorBorder;}
	}
}
.section-custom-top{
	@include at-query($max, $small) {img{width: 100%}}
}

/*============================================================================
	#Sidebar
==============================================================================*/
/* .sidebar{
	font-family: $headerFontStack;
	.widget__title {
		@extend h2.title;
		padding: 9px 0;
		position: relative;
		font-size: 18px;
		text-align: left;
		text-transform: uppercase;
		margin-bottom: 20px;

		&:before {
		    bottom: -12px;
		    background-position: -49px -35px;
		    background-repeat: no-repeat;
		    left: 0;
		    margin-left: 0;
		}
	}
	.widget {margin-bottom: $gridGutter;}
	ul {
		list-style: none;
		margin: 0;
	}
	ul.menu li {
		a {
			display: block;
			padding: 7px 20px;
			border-bottom: 1px solid $colorBorder;

			span {
				color: #bbb;
				float: right;
			}
		}
		&:hover a, &.filter--active a {
		}
	}

	.widget-blog-recent{
		.article{
			border-bottom: 1px solid $colorBorder;
			padding-bottom: 10px; margin-bottom: 10px;
		}
	}
}
.widget-product {
	.item {
		overflow: hidden;
		margin-bottom: 10px;
	}
	.product-image {
		width: 70px;
		float: left;
		margin-right: 10px;
	}
	.product-name{
		border-bottom: 1px solid $colorBorder;
    margin-bottom: 15px;
    display: inline-block;
	}
	.spr-badge-caption{display: none;}
} */
/*============================================================================
	#Product and Collection Grids
==============================================================================*/
.grid__image {
	display: block;
	img {
		display: block;
		margin: 0 auto;
	}
	.large--display-table &{margin-bottom: 10px;}
}
.product-container{
	text-align: center;
	margin-bottom: 20px!important;
	position: relative;
	.swatch{
	position: absolute;
    margin: 0;
    text-align: left;
    top: 12px;
    left: 12px;
	}
	.swatch .swatch-element{
		    display: block;
    float: none;
        margin-bottom: 3px;
    overflow: hidden;
	}
	.swatch label{
	    text-indent: -9999em;
	    border-radius: 100%;
	   	min-width: 15px !important;
    	height: 15px !important;
    	border: none;
	}
	.owl-item & {
		margin: 10px;
	}
	.product-image {
		position: relative;
		text-align: center;
		overflow: hidden;
	}
	.product-thumbnail {
		position: relative;
	}
	.product-actions {
		background-color: #ffffff;
		padding: 20px 0;
		text-align: center;
		-webkit-box-shadow: 2px 4px 5px 0px rgba(0, 0, 0, 0.09);
		box-shadow: 2px 4px 5px 0px rgba(0, 0, 0, 0.09);
		position: absolute;
		left: 5%;
		width: 90%;
		bottom: -20px;
		opacity: 0;
		visibility: hidden;
		-webkit-transition: all 0.25s ease-in-out;
		-o-transition: all 0.25s ease-in-out;
		transition: all 0.25s ease-in-out;
	}
	.back-img {
		position: absolute;
		top: 0;
		left: 0;
		opacity: 0;
		visibility: hidden;
		transition: all ease 300ms;
	}
	.btn {
		background: transparent;
		border: transparent;
		padding: 0 20px;
		border-left: solid 1px $colorBorder;
		display: inline-block;
		color: #000;

		&:hover {
			color: $colorDefault;
		}
		&.wishlist span {
			display: none;
		}
	}
	form {
		display: inline-block;

		&.add-to-cart .btn {
			border-left: 0;
		}
	}
	.product-meta {
		padding: 20px;
		width: 100%;
		display: inline-block;
		transition: all ease 300ms;

		h4 {
			font-size: 14px;
			color: $colorBody;
			text-transform: none;
			font-weight: normal;
			display: inline-block;
			border-bottom: 1px solid $colorBorder;
			padding-bottom: 3px;
			position: relative;
			&:before{
				position: absolute;
				content: "";
				width: 0;
				transition: width ease 0.3s;
				height: 1px;
				background-color: $colorDefault;
				bottom: -1px;
				left: 0;
			}
		}
	}
	&:hover {
		.back-img {
			visibility: visible;
			opacity: 1;
			transition: all ease 300ms;
			@include backface();
		}
		.product-actions {
			opacity: 1;
			visibility: visible;
			bottom: 10px;
			transition: all ease 300ms;
		}
		.product-meta h4:before{
			width: 100%;
			transition: width ease 0.3s;
		}
	}
	.sale-price {
		color: #999;
		font-weight: normal;
	}
	.label {
		background: $colorDefault;
		width: 50px;
		height: 50px;
		border-radius: 100%;
		position: absolute;
		top: 20px;
		right: 20px;
		line-height: 50px;
		text-align: center;
		text-transform: uppercase;
		font-weight: normal;
		padding: 0;

		&.new {
			background: #17c187;
			left: 20px;
		}
		&.sold-out {
		}
		&.on-sale {
		}
	}
}
/*
.product-price {font-weight: 700; color: #000;font-family: $headerFontStack; }
*/
// quickview
.swatch{margin:0 0 24px 0;text-transform:capitalize;font-size:1.4rem;display: flex;align-items: center;
.crossed-out{display: none;}}
.swatch .header{margin:0 5px 0 0;float:left;min-width:65px;color:#212121;line-height:25px}
.swatch input{display:none!important}
.swatch-element label{padding:0 10px}
.color.swatch-element label{padding:0}
.swatch input:checked+label{font-weight:600;background:#000;color:#FFF;}
.swatch [class*="color"] input:checked+label{border:0px solid #31373d}
.swatch .swatch-element{float:left;-webkit-transform:translateZ(0);-webkit-font-smoothing:antialiased;margin:0px 10px 0 0;position:relative}
.swatch .swatch-element.color label{position:relative}
.swatch .swatch-element.color label:before{content:url();position:absolute;width:100%;height:100%;top:0;left:0;opacity:0;visibility:hidden;line-height:40px}
.swatch .swatch-element.color input:checked+label:before{opacity:1;visibility:visible}
.crossed-out{position:absolute;width:100%;height:100%;left:0;top:0}
.swatch .swatch-element .crossed-out{display:none}
.swatch .swatch-element.soldout .crossed-out{display:block}
.swatch .swatch-element.soldout label{filter:alpha(opacity=60);-khtml-opacity:0.6;-moz-opacity:0.6;opacity:0.6}
.swatch .tooltip{display:none;}
.swatch.error{background-color:#e8d2d2!important;color:#333!important;padding:1em;border-radius:5px}
.swatch.error p{margin:0.7em 0}
.swatch.error p:first-child{margin-top:0}
.swatch.error p:last-child{margin-bottom:0}
.swatch.error code{font-family:monospace}
.quickview-product .selector-wrapper{display:none;}
.quickview-product .total-price{margin-bottom: 15px;}

//Collection Grids
.collection__image{margin-bottom: $gutter;}
.collection__info{}
.collection__sort{
	#SortBy{border:none;}
}

/*============================================================================
	#Collection Filters
==============================================================================*/
.filter--active {
	font-weight: bold;
}

/*============================================================================
	#Breadcrumbs
==============================================================================*/
.breadcrumb {
	margin-bottom: $gutter;

	a,
	span {
		display: inline-block;
		padding: 0 7px 0 0;

		&:first-child {
			padding-left: 0;
		}
	}
}


/*============================================================================
	#Product Page
==============================================================================*/
.product-single__variants {
	display: none;

	.no-js & {
		display: block;
	}
}

.product-single__photos {
	margin-bottom: $gutter;
}
.product-single__thumbnails{
	height: 615px;
    margin: 0;
	.product__thumbnails{width: 80px; margin: 0 0 20px;
		@include at-query ($max, $small) {
			float: left;
    		margin-right: 4px;
		}
	}
}
.product-single__photos,
.product-single__thumbnails {
	a, img {
		display: block;
		margin: 0 auto;
	}

	li {
	margin-bottom: 15px;
	}
}

.product-single{
	#AddToCart{width: 100%;}
	#AddToCartText {
		padding-left: 30px;
		position: relative;
		text-transform: uppercase;
		font-weight: normal;
	}
	.wishlist{
		    width: 100%;
    background: #fff;
    color: #000;
    border-bottom: 1px solid $colorBorder;
    &:hover{color: $colorDefault;}
	}

}

.des-short{margin-top: 15px;}
.add-this{
	text-align: center;
	margin: 20px 0;
	.addthis_toolbox{display: inline-block;}
}

.product-tabs{margin-bottom: 20px;}
.selector-wrapper{
	display: none; 
	label[for]{
		float: left;
		min-width: 60px;
		line-height: 39px;
	}
	select{}
}

// review
.spr-icon {
    font-size: 9px!important; float: none !important;}
.spr-review-header-title,
.spr-header-title {
    font-size: 14px!important;}
.spr-container{padding: 0!important; border: none!important;}
// quickzoom
.cloud-zoom-big {
	overflow: hidden
}
.cloud-zoom-lens {
	background-color: #fff;
	cursor: move
}
.cloud-zoom-wrap {
	top: 0;
	z-index: 9999;
	position: relative
}


.cloud-zoom-loading {
	color: white;
	background: #222;
	padding: 3px
}
.product-single__photos {
	text-align: center;
	position: relative;
	z-index: 40
}
.product-single__photos img {
	width: 100%
}
.product-single__photos a {
	display: block;
	text-align: center
}


/*============================================================================
	#Blogs page
==============================================================================*/
article{
	.post-thumbnail{margin-bottom: 30px; img{margin-bottom: 15px;    }}
/*	.entry-meta{font-style: italic; margin-bottom: 30px;} */
	.btn{
		    text-transform: uppercase;
    letter-spacing: 2px;
    font-weight: normal;
	}
}
.latest-posts-body{.entry-meta{padding:20px 30px;}
	.post-thumbnail{img{display:inline-block;}
	}
	.entry-title{text-transform:none;margin:15px 0;
		a{color:#000;}
	}
	em{color:#b9b9b9;}
}
.latest-posts-v1{h2{font-size:30px;text-align:left;    margin-top: 16px;}
	.latest-posts-body{border-top:1px solid $colorBorder;
		&:first-child{border-top:none;}
		img{border-radius: 100%;}
	}
	.post-thumbnail{width:110px;float:left;height:150px;margin-top:35px;margin-right:20px;}
	&:before{background: none !important;}
	& > div{position:relative;}
	.banner{position:absolute;

	}
}

.list-blog{
	.post-thumbnail{
		    float: left;
    margin-right: 30px;
	}
}


/*============================================================================
	#Notes and Form Feedback
==============================================================================*/
.note,
.errors {
	border-radius: $radius;
	padding: 6px 12px;
	margin-bottom: $gutter / 2;
	border: 1px solid transparent;
	font-size: 0.9em;
	text-align: left;

	ul,
	ol {
		margin-top: 0;
		margin-bottom: 0;
	}

	li:last-child {
		margin-bottom: 0;
	}

	p {
		margin-bottom: 0;
	}
}

.note {
	border-color: $colorBorder;
}

.errors {
	ul {
		list-style: disc outside;
		margin-left: 20px;
	}
}

.form-success {
	color: $successGreen;
	background-color: $successGreenBg;
	border-color: $successGreen;

	a {
		color: $successGreen;
		text-decoration: underline;

		&:hover {
			text-decoration: none;
		}
	}
}

.form-error,
.errors {
	color: $errorRed;
	background-color: $errorRedBg;
	border-color: $errorRed;

	a {
		color: $errorRed;
		text-decoration: underline;

		&:hover {
			text-decoration: none;
		}
	}
}


/*============================================================================
	#Cart Page
==============================================================================*/
.cart__row {
	position: relative;
	margin-top: $gutter;
	padding-top: $gutter;
	border-top: 1px solid $colorBorder;

	&:first-child {
		margin-top: 0;
	}

	&:first-child {
		padding-top: 0;
	}

	.js-qty {
		margin: 0 auto;
	}
	&.cart__header-labels{    border-top: none;font-size: 16px; color:#000;}
}

.cart-table {
	th {
		font-weight: bold;
	}

	td,
	th {
		padding: 30px 15px;
		border: none;
	}
}

@include at-query ($min, $large) {
	.cart__row--table-large {
		display: table;
		table-layout: fixed;
		width: 100%;

		.grid__item {
			display: table-cell;
			vertical-align: middle;
			float: none;
		}
	}
}

.cart__image {
	display: block;

	img {
		display: block;
		max-width: 100%;
	}
}

.cart__subtotal {
	margin: 0 0 0 ($gutter / 3);
	display: inline;
}

.cart__mini-labels {
	display: block;
	margin: ($gutter / 3) 0;
	font-size: em(12px);

	@include at-query ($min, $large) {
		display: none;
	}
}

.cart__remove {
	display: block;
}

/*============================================================================
	#Wishlist Page
==============================================================================*/
.wishlist-table{
	td.product-name{
		img{margin-right: 10px;}
	}
}
/*============================================================================
	#Contact Page
==============================================================================*/
.contact-box{
	.inner{
		height: 190px;
    vertical-align: middle;
    overflow: hidden;
    padding: 50px 0;
    margin: 50px 0 70px;
        line-height: 25px;
    border: 1px solid $colorBorder;
	}
	i{color: #000;font-size: 24px;}
}
/*============================================================================
	#Ajax Cart Styles (conditionally loaded)
==============================================================================*/
{% if settings.ajax_cart_method == "drawer" %}

.ajaxcart__inner {
	margin-bottom: $gutter;
}

.ajaxcart__row {
	> .grid {
		margin-left: -$gutter / 2;

		> .grid__item {
			padding-left: $gutter / 2;
		}
	}
}

.ajaxcart__product {
	position: relative;
	max-height: 500px;

	&.is-removed {
		max-height: 0;
		overflow: hidden;
		visibility: hidden;
		transition: all 450ms cubic-bezier(0.57,.06,.05,.95);
		@include backface();
	}
}

.ajaxcart__row {
	padding-bottom: $gutter / 2;
	margin-bottom: $gutter / 2;
	border-bottom: 1px solid $colorDrawerBorder;
}

.ajaxcart__product-image {
	display: block;
	overflow: hidden;
	margin-bottom: 15px;

	img {
		display: block;
		margin: 0 auto;
		max-width: 100%;
	}
}

.ajaxcart__product-name,
.ajaxcart__product-meta {
	display: block;
}

.ajaxcart__product-name + .ajaxcart__product-meta {
	padding-top: $gutter / 5;
}

/*================ Quantity Selectors ================*/
.js-qty {
	position: relative;
/*	margin-bottom: 1em; */
	max-width: 100px;
	min-width: 60px;
	overflow: visible;

	input {
		display: block;
		background: none;
		text-align: center;
		width: 100%;
		padding: 5px 25px;
		margin: 0;
	}
	& > span{
		@extend .js-qty__adjust;
		&.qtyplus{@extend .js-qty__adjust--plus;}
		&.qtyminus{@extend .js-qty__adjust--minus;}
	}
}

.js-qty__adjust {
	cursor: pointer;
	position: absolute;
	display: block;
	top: 0;
	bottom: 0;
	border: 0 none;
	padding: 8px;
	background: none;
	text-align: center;
	overflow: hidden;
	@include user-select(none);

	&:hover,
	&:focus {
		color: $colorPrimary;
	}
}

.js-qty__adjust--plus {
	right: 0;
}

.js-qty__adjust--minus {
	left: 0;
}

/*================ Quantity Selectors in Ajax Cart ================*/
.ajaxcart__qty {
	@extend .js-qty;
	margin: 0;

	.is-loading & {
		opacity: 0.5;
		transition: none;
	}
}

.ajaxcart__qty-num {
	border-color: $colorDrawerBorder;
	color: $colorDrawerText;
}

.ajaxcart__qty-adjust {
	@extend .js-qty__adjust;
	color: $colorDrawerText;
}

.ajaxcart__qty--plus {
	@extend .js-qty__adjust--plus;
	border-color: $colorDrawerBorder;
}

.ajaxcart__qty--minus {
	@extend .js-qty__adjust--minus;
	border-color: $colorDrawerBorder;
}

{% endif %} // settings.ajax_cart_method


/** Custom theme **/
// custom center
.custom-center{
	position: relative;
	    margin-bottom: 40px!important;
	    @include at-query($max, $small) {
	    	img{display: none;}
	    }
	.border{border-color: $colorBorder;}
	img{position: absolute; bottom: 8px;}
}

/*Custom Review apps*/
.spr-badge {
  .spr-icon, .spr-icon-star {
    font-size: 13px !important;
    margin-right: 1px;
  }
  .spr-badge-caption {
  	padding : 0 5px;
    color: #999;
    font-size: 12px !important;
  }
}

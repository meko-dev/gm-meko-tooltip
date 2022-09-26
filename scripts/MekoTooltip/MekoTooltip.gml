global.MekoTooltip_tooltips = [];
global.MekoTooltip_needRender = true;
global.MekoTooltip_hasVisible = false;
global.MekoTooltip_defaults = {
	texture: false,
	padding: 8,
	font: -1,
	maxWidth: -1
};

function MekoTooltip(_texture = false, _options = {}) {
	static get_dimensions = function() {
		var _baseWidth = options.padding * 2;
		var _baseHeight = options.padding * 2;

		var _boxNineslice = sprite_get_nineslice(options.texture);

		if (_boxNineslice.enabled) {
			_baseWidth += _boxNineslice.left + _boxNineslice.right;
			_baseHeight += _boxNineslice.left + _boxNineslice.right;
		}

		var _textMaxWidth = -1;

		if (options.maxWidth != -1) {
			_textMaxWidth = options.maxWidth - _baseWidth;
		}

		var _contentWidth = 0;
		var _contentHeight = 0;

		var _contentLength = array_length(content);

		for (var _contentIndex = 0; _contentIndex < _contentLength; _contentIndex++) {
			draw_set_font(options.font);

			content[_contentIndex].top = _contentHeight;

			var _widthOfText = string_width_ext(content[_contentIndex].text, -1, _textMaxWidth);

			if (_contentWidth < _widthOfText) {
				_contentWidth = _widthOfText;
			}

			var _marginBottom = content[_contentIndex].margin;

			if (_contentIndex == _contentLength - 1) {
				_marginBottom = 0;
			}

			_contentHeight += string_height_ext(content[_contentIndex].text, -1, _textMaxWidth) + _marginBottom;
		}

		var _tooltipWidth = _contentWidth + _baseWidth;
		var _tooltipHeight = _contentHeight + _baseHeight;

		return {
			width: _tooltipWidth,
			height: _tooltipHeight
		}
	}

	static add_content = function(text, options = {}) {
		options = MekoTooltipHelper_struct_merge({
			text: text,
			color: c_white,
			margin: 4
		}, options);

		array_push(content, options);

		global.MekoTooltip_needRender = true;
	}

	static clear_content = function() {
		content = [];

		global.MekoTooltip_needRender = true;
	}

	static show = function(x, y) {
		state.x = x;
		state.y = y;

		state.visible = true;

		global.MekoTooltip_needRender = true;
		global.MekoTooltip_hasVisible = true;
	}

	static hide = function() {
		state.visible = false;

		global.MekoTooltip_needRender = true;
		global.MekoTooltip_hasVisible = false;

		var tooltipsLength = array_length(global.MekoTooltip_tooltips);

		for (var index = 0; index < tooltipsLength; index++) {
			if (global.MekoTooltip_tooltips[index].state.visible) {
				global.MekoTooltip_hasVisible = true;
				break;
			}
		}
	}

	static destroy = function() {
		var tooltipsLength = array_length(global.MekoTooltip_tooltips);

		for(var index = 0; index < tooltipsLength; index++) {
			if (global.MekoTooltip_tooltips[index] == self) {
				array_delete(global.MekoTooltip_tooltips, index, 1);
				break;
			}
		}

		hide();
	}
	
	_options = MekoTooltipHelper_struct_merge({
		texture: global.MekoTooltip_defaults.texture,
		padding: global.MekoTooltip_defaults.padding,
		font: global.MekoTooltip_defaults.font,
		maxWidth: global.MekoTooltip_defaults.maxWidth
	}, _options);

	if (_texture) {
		_options.texture = _texture;	
	}

	var _tooltip = {
		options: _options,
		state: {
			visible: false,
			x: 0,
			y: 0
		},
		content: [],
		get_dimensions: get_dimensions,
		add_content: add_content,
		clear_content: clear_content,
		show: show,
		hide: hide,
		destroy: destroy
	};

	array_push(global.MekoTooltip_tooltips, _tooltip);

	global.MekoTooltip_needRender = true;

	return _tooltip;
}

function MekoTooltip_set_defaults(_options = {}) {
	_options = MekoTooltipHelper_struct_merge(global.MekoTooltip_defaults, _options);

	global.MekoTooltip_defaults = _options;
}

function MekoTooltip_render() {
	if (!global.MekoTooltip_needRender) { return; }

	var _tooltipsLength = array_length(global.MekoTooltip_tooltips);

	for (var _index = 0; _index < _tooltipsLength; _index++) {
		var _tooltip = global.MekoTooltip_tooltips[_index];

		if (!_tooltip.state.visible) { continue; }

		var _baseWidth = _tooltip.options.padding * 2;
		var _baseHeight = _tooltip.options.padding * 2;

		var _boxNineslice = sprite_get_nineslice(_tooltip.options.texture);

		if (_boxNineslice.enabled) {
			_baseWidth += _boxNineslice.left + _boxNineslice.right;
			_baseHeight += _boxNineslice.left + _boxNineslice.right;
		}

		var _textMaxWidth = -1;

		if (_tooltip.options.maxWidth != -1) {
			_textMaxWidth = _tooltip.options.maxWidth - _baseWidth;
		}

		var _tooltipDimensions = _tooltip.get_dimensions();

		draw_sprite_stretched(_tooltip.options.texture, 0, _tooltip.state.x, _tooltip.state.y, _tooltipDimensions.width, _tooltipDimensions.height);

		var _contentLength = array_length(_tooltip.content);

		for (var _contentIndex = 0; _contentIndex < _contentLength; _contentIndex++) {
			draw_set_font(_tooltip.options.font);

			var _x = _tooltip.state.x + _boxNineslice.left + _tooltip.options.padding;
			var _y = _tooltip.content[_contentIndex].top + _tooltip.state.y + _boxNineslice.top + _tooltip.options.padding;
			var _color = _tooltip.content[_contentIndex].color;

			draw_text_ext_color(_x, _y, _tooltip.content[_contentIndex].text, -1, _textMaxWidth, _color, _color, _color, _color, 1);
		}

		draw_set_font(-1);
	}

	global.MekoTooltip_needRender = false;
}

function MekoTooltipHelper_struct_merge(_structA, _structB) {
	var _returnStruct = _structA;
	var _propertyNames = variable_struct_get_names(_structB);

	for (var _index = 0; _index < array_length(_propertyNames); ++_index)	{
		variable_struct_set(_returnStruct, _propertyNames[_index], variable_struct_get(_structB, _propertyNames[_index]));
	}

	return _returnStruct;
}

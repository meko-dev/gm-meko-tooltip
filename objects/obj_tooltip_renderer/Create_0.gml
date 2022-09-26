var _fontMap = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-.,;:\"'?!()[]%& +";
var _font = font_add_sprite_ext(spr_font, _fontMap, true, 0);

MekoTooltip_set_defaults({
	texture: spr_gui_tooltip,
	maxWidth: 230,
	font: _font // or fnt_tooltip
});

tooltipSurface = surface_create(view_wport[0], view_hport[0]);

show_debug_overlay(true);

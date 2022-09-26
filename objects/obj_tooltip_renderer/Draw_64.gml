if (!surface_exists(tooltipSurface)) {
	tooltipSurface = surface_create(view_wport[0], view_hport[0]);	
}

if (global.MekoTooltip_needRender) {
	surface_set_target(tooltipSurface);
	draw_clear_alpha(c_black, 0);

	MekoTooltip_render();

	surface_reset_target();
}

if (global.MekoTooltip_hasVisible) {
	draw_surface(tooltipSurface, 0, 0);
}

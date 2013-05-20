void
moveresize(const Arg *arg) {

	XEvent ev;
	Monitor *m = selmon;

	if(!(m->sel && arg && arg->v))
		return;
	if(m->lt[m->sellt]->arrange && !m->sel->isfloating)
		togglefloating(NULL);

	resize(m->sel, m->sel->x + ((int *)arg->v)[0],
			m->sel->y + ((int *)arg->v)[1],
			m->sel->w + ((int *)arg->v)[2],
			m->sel->h + ((int *)arg->v)[3],
			True);

	while(XCheckMaskEvent(dpy, EnterWindowMask, &ev));
}



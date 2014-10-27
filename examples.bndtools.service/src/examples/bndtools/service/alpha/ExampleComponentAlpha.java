package examples.bndtools.service.alpha;

import examples.pde.service.alpha.PDEAlphaActivator;
import aQute.bnd.annotation.component.Component;

@Component
public class ExampleComponentAlpha {

	public ExampleComponentAlpha() {
		// feasible inside Eclipse IDE without a valid package import, due to
		// project dependency
		new PDEAlphaActivator();
	}

}
package examples.pde.service.beta;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

import examples.bndtools.service.alpha.ExampleComponentAlpha;

public class PDEBetaActivator implements BundleActivator {

	private static BundleContext context;

	static BundleContext getContext() {
		return context;
	}

	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	public void start(BundleContext bundleContext) throws Exception {
		PDEBetaActivator.context = bundleContext;
		new ExampleComponentAlpha();
	}

	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	public void stop(BundleContext bundleContext) throws Exception {
		PDEBetaActivator.context = null;
	}

}

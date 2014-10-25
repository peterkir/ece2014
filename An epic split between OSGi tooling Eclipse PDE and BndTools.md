General 

An epic split between OSGi tooling Eclipse PDE and BndTools

page #, name, ...
eclipse oomph setup for code


1. Title, picture
https://www.youtube.com/watch?v=M7FIvfx5J10

2. about me

3. overview
	os (win, linux)
	eclipse 3.8.2
	ant/eclipse based projects (no Maven, Tycho!)

4. comparison BND/BNDtools and Eclipse PDE
	solely BND
		multiple bundles from one eclipse project (-sub: *.bnd)
		bundle jars created instantly "on save"
		Declarative Service implementation based on BND or DS1.2 Annotations
		automated import package analysis (based on project "build target" -> bnd.bnd file)

	solely PDE
		Eclipse Features
		plugin.xml Editor
		import package based on complete PDE target
	
5. tooling setup 
	- Eclipse SDK 
	- p2.mirror BNDtools latest and install into Eclipse SDK
	- best friends are ... 
		"Target Platform State" view
		"Plug-ins" view
	
	- BND configuration project

6. target overview and creation
	p2 (site-based, directory based)
	obr (bindex)

7. design decisions
	PDE bundles depend on BND bundles
	avoid PDE, BND dependency cycles
	
8. development of PDE plugins
		import package flaw on "indirectly referenced class file dependency"

9. development of BND plugins
		target

10. launch configurations
		Store PDE Run configuration inside project
		Map Eclipse Features to bnd lib files

11. versioning
	.qualifier vs ${tstamp}
	PDE API Baselines vs BND baselining 
	(Attention: bnd baselining works only on building with the same JRE)

12. assembling products and applications 

13. building
	ant script
	
14. Q&A
	links and contact info
	
15. common pitfalls
	
Problem: 	PDE bundles depending on ext-point are 
	Origin:		Having BND based bundles containing an extension-point contribution
	Solution: 	buildBND2PDE -> set PDE Target -> restart required to satisfy depending PDE ext-point consumers
	
	Problem: 	PDE feature-based launch configurations are launching all fragments
	Origin:
	Solution:
	
	Problem: 	BND based bundles are not inside PDE launch
	Origin:
	Solution:

	Problem:	Code Browsing -> class file from target
	Origin:		BND bundle resides in target and according source project 
	Solution:
	
	Problem:	BNDtools default configuration settings is storing the repository cache inside %USERPROFILE%
	Origin:		Enterprise user profiles are often roamed and storing the repository inside is blasting them
	Solution:	Configure a machine specific location
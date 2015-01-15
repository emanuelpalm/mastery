CD = cd

release:
	@$(CD) account && $(MAKE) release 
	@$(CD) client && $(MAKE) release 
	@$(CD) server && $(MAKE) release 

clean: 
	@$(CD) account && $(MAKE) clean 
	@$(CD) client && $(MAKE) clean 
	@$(CD) server && $(MAKE) clean 

.PHONY: release clean

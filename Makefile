BINDIR = bin
BINARY = HelloCrystalWorld
CR = $(HOME)/crystal/bin/crystal

$(BINDIR)/$(BINARY): src/HelloCrystalWorld.cr src/HelloCrystalWorld/*.cr
	$(CR) build --release $< -o $(BINDIR)/$(BINARY)

release: $(BINDIR)/$(BINARY)

#!/usr/bin/env ion

SKILLS = cards/skills.crd cards/diss.crd cards/values.crd 

NAMES = cards/names.crd

default:all

all: out/all_names.pdf out/all_skills.pdf
	

clean:
	rm out/*

out/all_skills.pdf: $(SKILLS)
	any_cards -f $(SKILLS) -t main.tp -o out/skills -a 2 -d 5 --margin 150
	for x in out/skillsf_*.svg ; do \
		echo "Converting $$x" ;\
		export name=`echo "$$x" | cut -f 1 -d '.'`  ;\
		echo "Name = $$name" ;\
		inkscape -f $$x -A $$name.pdf ; \
		echo "done" ;\
	done
	pdfunite out/skillsf_*.pdf out/all_skills.pdf


out/all_names.pdf: $(NAMES)
	any_cards -f $(NAMES) -t names.tp -o out/names -a 2 -d 5 --margin 150
	for x in out/namesf_*.svg ; do \
		echo "Converting $$x" ;\
		export name=`echo "$$x" | cut -f 1 -d '.'`  ;\
		echo "Name = $$name" ;\
		inkscape -f $$x -A $$name.pdf ; \
		echo "done" ;\
	done
	pdfunite out/namesf_*.pdf out/all_names.pdf



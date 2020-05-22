#!/usr/bin/env ion

SKILLS = cards/skills.crd cards/diss.crd cards/values.crd 
ITEMS = cards/items.crd cards/weapons.crd

NAMES = cards/names.crd

default:all

all: out/all_names.pdf out/all_skills.pdf out/rules.html out/chargen.html out/all_camp_chars.pdf out/all_items.pdf out/cboard.svg
	

clean:
	rm out/*

out/all_skills.pdf: $(SKILLS) templates/main.tp
	any_cards -f $(SKILLS) -t templates/main.tp -o out/skills -a 2 -d 5 --margin 200
	for x in out/skillsf_*.svg ; do \
		echo "Converting $$x" ;\
		export name=`echo "$$x" | cut -f 1 -d '.'`  ;\
		echo "Name = $$name" ;\
		inkscape -f $$x -A $$name.pdf ; \
		echo "done" ;\
	done
	pdfunite out/skillsf_*.pdf out/all_skills.pdf

out/all_items.pdf: $(ITEMS) templates/item.tp
	any_cards -f $(ITEMS) -t templates/item.tp -o out/items -a 2 -d 5 --margin 200
	for x in out/itemsf_*.svg ; do \
		echo "Converting $$x" ;\
		export name=`echo "$$x" | cut -f 1 -d '.'`  ;\
		echo "Name = $$name" ;\
		inkscape -f $$x -A $$name.pdf ; \
		echo "done" ;\
	done
	pdfunite out/itemsf_*.pdf out/all_items.pdf


out/all_names.pdf: $(NAMES)
	any_cards -f $(NAMES) -t templates/names.tp -o out/names -a 2 -d 5 --margin 150
	for x in out/namesf_*.svg ; do \
		echo "Converting $$x" ;\
		export name=`echo "$$x" | cut -f 1 -d '.'`  ;\
		echo "Name = $$name" ;\
		inkscape -f $$x -A $$name.pdf ; \
		echo "done" ;\
	done
	pdfunite out/namesf_*.pdf out/all_names.pdf

out/rules.html:cards/* templates/rules.tp actions/*
	cardtemplater -t templates/rules.tp > out/rules.html

out/chargen.html:cards/* templates/char_gen.tp.html actions/*
	cardtemplater -t templates/char_gen.tp.html > out/chargen.html

out/all_camp_chars.pdf: the_campaign/chars.crd templates/character.tp
	any_cards -f the_campaign/chars.crd -t templates/character.tp -o out/camp_chars -a 2 -d 5 --margin 150
	for x in out/camp_charsf_*.svg ; do \
		echo "Converting $$x" ;\
		export name=`echo "$$x" | cut -f 1 -d '.'`  ;\
		echo "Name = $$name" ;\
		inkscape -f $$x -A $$name.pdf ; \
		echo "done" ;\
	done
	pdfunite out/camp_charsf_*.pdf out/all_camp_chars.pdf



out/cboard.svg: templates/charboard.tp templates/charboard_des.crd
	any_cards -f templates/charboard_des.crd -t templates/charboard.tp -a 9 -d 2 -o out/cboard --margin 200

TARGET=example

all: $(TARGET).pdf
	echo done

$(TARGET).dvi: $(TARGET).tex
	latexmk -shell-escape $(TARGET).tex

$(TARGET).pdf: $(TARGET).dvi
	dvipdf $(TARGET).dvi

code: $(TARGET).dvi
	echo 'from math import *' > $(TARGET).all.py
	ls $(TARGET)*.tmp.py | sort -V | xargs cat | grep -v '^from ' >> $(TARGET).all.py
	sed -i '/^savevar/d;/^printme/d;/^printvar/d;/^endprint/d' $(TARGET).all.py

clean:
	$(RM) *.tmp.* $(TARGET).dvi $(TARGET).aux $(TARGET).log $(TARGET).toc

clean-gen: clean
	$(RM) $(TARGET).pdf $(TARGET).all.py *.pyc

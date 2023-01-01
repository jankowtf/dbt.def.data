---
output: 
    html_document:
        css: custom.css
        keep_md: yes
params:
    x: "Abteilung"
    y: "Weggang"
---

<style type="text/css">
.main-container {
  max-width: 1800px;
  margin-left: auto;
  margin-right: auto;
}
</style>



## Was passiert hier? {#dbt_default .emphasized}

In diesem Schritt geht es darum, das Gesamtproblem insofern einzugrenzen, dass man sich hypothesengetrieben den verfügbaren Daten nährt.

In unserem speziellen Fall bedeutet dies, dass wir uns die Variable `Weggang` genauer anschauen: wir möchten zunächst herausfinden, ob es abteilungsspezfische (Variable `Abteilung)`Unterschiede gibt.

### Als Hypothese ausgedrückt:
> Es gibt abteilungsübergreifende Unterschiede hinsichtlich der Mitarbeiterfluktuation

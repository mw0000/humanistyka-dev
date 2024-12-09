install.packages("cronR")
library(cronR)

# Ścieżka do skryptu R
rscript_path <- "bot.R"

# Generowanie polecenia dla cron
cmd <- cron_rscript(rscript_path)

# Dodanie zadania do Crontab
cron_add(
  command = cmd,               # Polecenie do uruchomienia
  frequency = "*/5 * * * *",   # Co 5 minut
  id = "publish_task",         # Identyfikator zadania
  description = "Publikowanie co 5 minut"
)

# Sprawdzenie listy aktywnych zadań
cron_ls()

# stop
#cron_rm(id = "publish_task")
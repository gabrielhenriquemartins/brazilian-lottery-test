*** Variables ***
### Static Variables
@{lottery_games}               Lotofácil  Federal  Quina  Timemania  Mega Sena  Dia de Sorte  Dupla Sena  Lotomania

${current_day_field}             //*[@class="vk_bk dDoNo FzvWSb"]
${current_time_field}            //*[@class="gsrt vk_bk FzvWSb YwPhnf"]
${google_result_holder}          //*[@class="zSMazd UHlKbe"] | //*[@class="zSMazd wdqZ2d UHlKbe"] | //*[@class="zSMazd ZVkP3"]
${loteria_federal_holder}        //*[@class="ng-binding ng-scope"] | //*[@class="ng-binding dezena ng-scope"]

### Interactive Variables
${tf_input_search}       //input[@aria-label="Pesquisar"]
${clean_input_search}    //*[@class="M2vV3 vOY7J"]
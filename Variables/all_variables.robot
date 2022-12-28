*** Variables ***
### Static Variables
@{day_of_the_week}             segunda-feira    terça-feira    quarta-feira    quinta-feira    sexta-feira    sábado       domingo
@{lottery_games}               Quina            Timemania      Mega Sena       Dia de Sorte    Dupla Sena     Lotomania

${current_day_field}             //*[@class="vk_bk dDoNo FzvWSb"]
${current_time_field}            //*[@class="gsrt vk_bk FzvWSb YwPhnf"]
${google_result_holder}          //*[@class="zSMazd UHlKbe"]

### Interactive Variables
${tf_input_search}       //input[@aria-label="Pesquisar"]
${clean_input_search}    //*[@class="M2vV3 vOY7J"]
*** Variables ***

&{eventbrite}
...   btn_search=xpath://button[@data-spec="search-button"]    
...   paginator=xpath://li[@class="eds-pagination__navigation-minimal eds-l-mar-hor-3"]
...   elements_li=xpath://*[@id="root"]/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section/ul/li
...   event_link=xpath://*[@id="root"]/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section/ul/li[{variable_value}]/div/div[2]/section/div/section[2]/div/a
...    event_title=xpath://*[@id="root"]/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section/ul/li[{variable_value}]/div/div[2]/section/div/section[2]/div/a/h2
...   event_day=xpath://*[@id="root"]/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section/ul/li[{variable_value}]/div/div[2]/section/div/section[2]/div/p[1]
...    venue_event=xpath://*[@id="root"]/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section/ul/li[{variable_value}]/div/div[2]/section/div/section[2]/div/p[2]
...   event_price=xpath://*[@id="root"]/div/div[2]/div/div/div/div[1]/div/main/div/div/section[1]/div/section/div/div/section/ul/li[{variable_value}]/div/div[2]/section/div/section[2]/div/p[3] 
...    next_page=xpath://button[@data-spec="page-next"]
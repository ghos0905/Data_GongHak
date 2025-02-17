
library(krvotes)
library(tidyverse)

`�Ѽ�_df` <- congress_2018 %>%
  filter(str_detect(`precinct`, "�����úд籸��")) %>%
  unnest(data_clean) %>%
  group_by(`���鵿��`) %>%
  summarise(`����` = sum(`���Ҿ���ִ� �躴��`, na.rm=TRUE),
            `����` = sum(`�������� ������`, na.rm=TRUE),
            `�� ��` = sum(`�����Ǵ� ������`, na.rm=TRUE))%>%
  mutate(`����`="2016�Ѽ�")

`�д�_df` <- bind_rows(`�Ѽ�_df`) %>% 
  filter(!str_detect(`���鵿��`, "�߸�")) %>% 
  select(`����`, everything())


`�д�_df` %>% 
  gather(`����`, `��ǥ��`, -`����`, -`���鵿��`) %>% 
  mutate(`����` = factor(`����`, levels = c("����", "����", "�� ��"))) %>% 
  group_by(`����`, `����`) %>% 
  summarise(`��ǥ��` = sum(`��ǥ��`)) %>% 
  spread(`����`, `��ǥ��`) %>% 
  DT::datatable()



from faker import Faker
import pandas as pd
import logging

if __name__=="__main__":
    logging.info("Start sscript - generating train dataset using faker library")

    fake = Faker()
    Faker.seed(0)
    thelist = []
    for x in range(50000):
        dataset = {'app_name': fake.bothify(text='????-####'),
                'generation_date': fake.date_between(start_date='-2y', end_date='today'),
                'ip': fake.ipv4(),
                'status': fake.random_element(elements=('terminated', 'running','started'))}

        dataset_copy = dataset.copy()    
        thelist.append(dataset_copy)
    dataset_frame = pd.DataFrame(thelist)
    dataset_frame.head(10)

    output_path = "train-dataset/"
    dataset_frame.to_csv(f'{output_path}train_dataset.csv')
    logging.info(f"Dataset generated at this folder: {output_path}")


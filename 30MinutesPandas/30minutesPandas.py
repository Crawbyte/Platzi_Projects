import pandas as pd
df = pd.read_csv("./data/tweets.csv", index_col="id")
print(df)
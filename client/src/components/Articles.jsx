import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Typography from "@material-ui/core/Typography";
import Grid from "@material-ui/core/Grid";
import Card from "@material-ui/core/Card";
import CardActionArea from "@material-ui/core/CardActionArea";
import CardContent from "@material-ui/core/CardContent";
import { Button } from "@material-ui/core";
import axios from "../helpers/axios";
import { articles_api } from "../constants/apis";

const useStyles = makeStyles({
  articlesWrapper: {
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    flexWrap: "wrap",
  },
  card: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    justifyContent: "center",
    margin: "1rem",
  },
  cardDetails: {
    flex: 1,
  },
  cardMedia: {
    width: 160,
  },
});

const Article = ({ article, isAdmin, setUpdateArticles }) => {
  const classes = useStyles();
  const handleApproveArticle = (id) => {
    axios
      .get(`${articles_api(id)}/approve`)
      .then((data) => setUpdateArticles(article.attributes.id));
  };

  const handleDeleteArticle = (id) => {
    axios
      .delete(`${articles_api(id)}`)
      .then((data) => setUpdateArticles(article.attributes.id));
  };

  return (
    <Grid item xs={12} md={6} className={classes.card}>
      <CardActionArea component="a" href="#">
        <Card className={classes.card}>
          <div className={classes.cardDetails}>
            <CardContent>
              <Typography component="h2" variant="h5">
                {article?.attributes?.title}
              </Typography>
              <Typography variant="subtitle1" color="textSecondary">
                by:{article.attributes?.user}
              </Typography>
              <Typography variant="subtitle1" paragraph>
                {article.attributes?.description}
              </Typography>
            </CardContent>
          </div>
        </Card>
      </CardActionArea>
      {article.attributes.status === "pending" && (
        <Button
          variant="contained"
          color="primary"
          onClick={() => handleApproveArticle(article.attributes.id)}
        >
          Approve
        </Button>
      )}

      {isAdmin && (
        <Button
          style={{ marginTop: "1rem", maxWidth: "500px" }}
          variant="contained"
          color="secondary"
          onClick={() => handleDeleteArticle(article.attributes.id)}
        >
          Delete
        </Button>
      )}
    </Grid>
  );
};

const Articles = ({ articles, isLoading, isAdmin, setUpdateArticles }) => {
  const classes = useStyles();
  const renderArticles = () => {
    if (articles?.length > 0)
      return articles.map((article) => (
        <Article
          isAdmin={isAdmin}
          article={article}
          setUpdateArticles={setUpdateArticles}
        />
      ));
  };
  if (isLoading) {
    return <span>Loading...</span>;
  }

  return <div className={classes.articlesWrapper}>{renderArticles()}</div>;
};

export default Articles;

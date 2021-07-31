import { useEffect, useState } from "react";
import axios from "./helpers/axios";
import "./App.css";
import Articles from "./components/Articles";
import LoginForm from "./components/LoginForm";
import { articles_api } from "./constants/apis";
import useAsync from "./custom-hooks/useAsync";

function App() {
  const [isLogged, setIsLogged] = useState(false);
  const [isAdmin, setIsAdmin] = useState(false);
  const [updateArticle, setUpdateArticles] = useState();
  const { data: articles, status, run } = useAsync();

  const fetchArticles = () => {
    return axios.get(articles_api());
  };

  useEffect(() => {
    run(fetchArticles());
  }, [run, isLogged, updateArticle]);

  return (
    <div className="App">
      {!isLogged && (
        <LoginForm setIsLogged={setIsLogged} setIsAdmin={setIsAdmin} />
      )}
      <Articles
        isLogged={isLogged}
        isAdmin={isAdmin}
        isLoading={status === "pending"}
        articles={articles}
        setUpdateArticles={setUpdateArticles}
      />
    </div>
  );
}

export default App;

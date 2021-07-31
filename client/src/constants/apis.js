export const articles_api = (id = null) => {
  if (id) return `articles/${id}`;
  else return `articles`;
};

export const auth_api = () => {
  return "/users";
};

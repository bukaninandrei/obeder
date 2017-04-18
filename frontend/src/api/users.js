import urljoin from 'url-join';

import { baseUrl, request, apiClientFactory } from './apiClient';

const url = urljoin(baseUrl, 'user');
const apiWrapper = apiClientFactory(url);

apiWrapper.getUser = () => apiWrapper.getOne(null);
apiWrapper.saveUser = fields => apiWrapper.save(null, fields);

apiWrapper.getMenus = () => request(urljoin(url, 'menus'), 'GET');
apiWrapper.setMenu = (id, { dishes, description, neem }) => {
  const menuUrl = urljoin(baseUrl, 'user_menus', id);
  const payload = {
    user_menu: { dishes, description, neem },
  };

  return request(menuUrl, 'PUT', false, payload);
};

apiWrapper.setVote = (dishId, voteType) => {
  const voteUrl = urljoin(baseUrl, 'votes', dishId, 'dish');
  return request(voteUrl, 'PUT', false, { vote_type: voteType });
};
export default apiWrapper;

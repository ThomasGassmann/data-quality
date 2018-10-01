import React from 'react';
import { Query } from "react-apollo";
import IndicatorRepository from './../../repository/IndicatorRepository';
import DataTable from '../Dashboard/DataTable';
import RouterButton from './../../Components/FormInput/RouterButton';

const IndicatorList = (refetch) => {
  const listPageParams = IndicatorRepository.getListPage(1, 10);
  return (<Query
    query={listPageParams.query}
    variables={listPageParams.variables}
    fetchPolicy={refetch ? 'cache-and-network' : 'cache-first'}
  >
    {({ loading, error, data }) => {
      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error :(</p>;
      return (
        <div>
          Indicator list
          <div style={{ float: 'right' }}>
            <RouterButton targetLocation='/indicator/new' disabled={false} label="Add new indicator" />
          </div>
          <DataTable data={data.allIndicators.nodes} />
        </div>
      );
    }}
  </Query>);
};

export default IndicatorList;
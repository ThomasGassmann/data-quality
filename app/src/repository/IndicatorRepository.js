import gql from "graphql-tag";

class IndicatorRepository {
  static getListPage(pageNumber, pageSize) {
    const offset = pageSize * (pageNumber - 1);
    const query = gql`
      query IndicatorsQuery($pageSize: Int!, $offset: Int!) {
        allIndicators(first: $pageSize, offset: $offset) {
          nodes {
            id
            name
            description
            executionOrder
            flagActive
            createdDate
            updatedDate
            indicatorTypeId
          }
        }
      }`;
    return {
      query: query,
      variables: {
        offset: offset,
        pageSize: pageSize
      }
    };
  }

  static getFormDropdownData() {
    return gql`
      {
        allIndicatorTypes {
          nodes {
            id
            name
          }
        }
        allIndicatorGroups {
          nodes {
            id
            name
          }
        }
      }`;
  }

  static insert() {
    return gql`
      mutation addNewIndicator($indicator: IndicatorInput!) {
        createIndicator(input: { indicator: $indicator }) {
          indicator {
            id
            name
            description
            createdDate
            updatedDate
          }
        }
      }`;
  }
}

export default IndicatorRepository;
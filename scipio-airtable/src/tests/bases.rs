use rstest::rstest;
use tracing_test::traced_test;
use super::fixtures::{context, AsyncTestContext};

#[cfg(feature = "integration")]
#[rstest]
#[traced_test]
#[tokio::test]
pub async fn test_list_bases(context: AsyncTestContext) {
    let bases_response = context.airtable.list_bases(None).await.unwrap();
    dbg!(&bases_response);
}

// #[cfg(feature = "integration")]
// #[rstest]
// #[tokio::test]
// pub async fn test_get_base_schema(airtable: Airtable) {
//     let bases_response = airtable.list_bases(None).await.unwrap();
//     let base_id =
//         bases_response.bases.first().expect("there should be at least one base").id.as_str();
//     let schema_response = airtable.get_base_schema(base_id, vec![]).await.unwrap();
//     dbg!(&schema_response);
// }